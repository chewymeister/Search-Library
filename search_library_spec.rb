# Find a word in a directory of file inside the file data

require 'rspec'
require 'fileutils'

class SearchLibrary
  def initialize root_dir
    @root_dir = root_dir
    @filenames = []
  end

  def find search_term
    Dir.foreach(@root_dir) do |file_item|
      next if file_item == '.' or file_item == '..'

      if search_term_found? file_item, search_term
        add_to_results file_item
      end
    end

    @filenames
  end

  def add_to_results file_item
    @filenames << @root_dir + file_item
  end
  
  def search_term_found? file_item, search_term
    contains_search_term = file_item.include?(search_term)
  end

  def read_contents_of(file_item)
    File.open(@root_dir + file_item).read
  end
end

describe SearchLibrary do
  let(:test_dir) { "./test/" }
  let(:search_library) { SearchLibrary.new(test_dir) }
  before do
    prepare_test_dir
  end

  after do
    clean_test_dir
  end

  context "when there is one file" do

    it "should find the word yes, and return file name" do
      filename = "#{test_dir}yes.txt"
      write_test_file_for filename
      
      expect(search_library.find("yes")).to eq [filename]
    end

    it "should find the word yes, and return file name" do
      filename = "#{test_dir}second_yes.txt"
      write_test_file_for filename

      expect(search_library.find("yes")).to eq [filename]
    end
  end

  context "when there are two files" do
    it "should find the word yes and return file name" do
      file_name_one = "#{test_dir}yes.txt"
      file_name_two = "#{test_dir}second_yes.txt"
      write_test_file_for file_name_one
      write_test_file_for file_name_two
       
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
