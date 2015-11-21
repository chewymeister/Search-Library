class SearchLibrary
  def initialize root_dir
    @root_dir = root_dir
    @filenames = []
  end

  def find search_term
    Dir.foreach(@root_dir) do |file_item|
      next if file_item == '.' or file_item == '..'

      if is_a_directory? file_item
        @filenames << create_new_search_for(file_item, search_term)
      elsif search_term_found? file_item, search_term
        add_to_results file_item
      end
    end

    @filenames.flatten
  end

  def create_new_search_for file_item, search_term
    SearchLibrary.new(@root_dir + file_item + "/").find(search_term)
  end

  def is_a_directory? file_item
    File.directory? @root_dir + file_item
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
