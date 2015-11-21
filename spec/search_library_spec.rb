require 'rspec'
require 'spec_helper'
require 'fileutils'

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

  context "when there are two directories" do
    it "should find the word yes and return file name" do
      nested_dir = "nested_dir/"
      file_name_one = "#{test_dir}yes.txt"
      file_name_two = "#{test_dir + nested_dir}second_yes.txt"
      write_test_file_for file_name_one
      create_nested_directory_for file_name_two, test_dir, nested_dir
      write_test_file_for file_name_two
       
      expect(search_library.find("yes").sort).to eq [file_name_one, file_name_two].sort
    end
  end

  context "when there are three directories" do
    it "should find the word yes and return file name" do
      nested_dir = "nested_dir/"
      deeply_nested_dir = "deeply_nested_dir/"

      file_name_one = "#{test_dir}yes.txt"
      file_name_two = "#{test_dir + nested_dir}second_yes.txt"
      file_name_three = "#{test_dir + nested_dir + deeply_nested_dir}third_yes.txt"

      write_test_file_for file_name_one

      create_nested_directory_for file_name_two, test_dir, nested_dir
      write_test_file_for file_name_two

      create_nested_directory_for file_name_three, (test_dir + nested_dir), deeply_nested_dir
      write_test_file_for file_name_three
       
      expect(search_library.find("yes").sort).to eq [file_name_one, file_name_two, file_name_three].sort
    end
  end
end
