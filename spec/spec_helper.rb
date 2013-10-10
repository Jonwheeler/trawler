require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))

require 'lib/trawler'

def fixture_path(filename=nil)
  path = File.expand_path("../fixtures", __FILE__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end
