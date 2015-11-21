module Helpers
  def create_nested_directory_for filename, test_dir, nested_dir
    Dir.mkdir(test_dir + nested_dir) 
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
end
