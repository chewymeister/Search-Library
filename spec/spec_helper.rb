require_relative '../lib/search_library'
require_relative 'support/helpers'

RSpec.configure do |config|
  config.include Helpers
  config.color = true
  config.formatter = :documentation
end
