# Find a word in a directory of file inside the file data

require 'rspec'
require 'fileutils'

class SearchLibrary
  def initialize root_dir
    @root_dir = root_dir
    @file_names = []
  end

  def find search_term
    files = Dir.foreach(@root_dir) do |item|
      next if item == '.' or item == '..'
      file = File.open(@root_dir + item)
      contents = file.read
      contains_search_term = contents.include?(search_term)

      if contains_search_term
        @file_names << @root_dir + item
      end
    end

    @file_names
  end
end

describe SearchLibrary do
  let(:test_dir) { "./test/" }
  before do
    prepare_test_dir
  end

  after do
    clean_test_dir
  end

  context "when there is one file" do
    it "should find the word yes, and return file name" do
      file_name = "#{test_dir}yes.txt"
      File.open(file_name, 'w') { |file| file.write("yes") } 
      
      search_library = SearchLibrary.new(test_dir)
      expect(search_library.find("yes")).to eq [file_name]
    end

    it "should find the word yes, and return file name" do
      file_name = "#{test_dir}second_yes.txt"
      File.open(file_name, 'w') { |file| file.write("yes") } 

      search_library = SearchLibrary.new(test_dir)
      expect(search_library.find("yes")).to eq [file_name]
    end
  end

  context "when there are two files" do
    it "should find the word yes and return file name" do
      file_name_one = "#{test_dir}yes.txt"
      file_name_two = "#{test_dir}second_yes.txt"
      write_test_file_for file_name_one
      write_test_file_for file_name_two
       
      search_library = SearchLibrary.new(test_dir)

      expect(search_library.find("yes").sort).to eq [file_name_one, file_name_two].sort
    end
  end
end

def write_test_file_for filename
  File.open(filename, 'w') { |file| file.write("yes") } 
end

def prepare_test_dir
  FileUtils.rm_rf(test_dir)
  Dir.mkdir(test_dir)
end

def clean_test_dir
  FileUtils.rm_rf("./test/")
end
