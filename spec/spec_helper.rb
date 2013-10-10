require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))

require 'lib/trawler'
