require "trawler/document"
require "trawler/parsed_document"
require "trawler/spider"
require "trawler/parser"
require "trawler/version"

module Trawler
  def self.fetch(url, options = {})
    Document.new(url, options).parse
  end
end
