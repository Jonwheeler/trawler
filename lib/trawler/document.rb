module Trawler
  class Document
    def initialize(url, options = {}) 
      @url     = url
      @options = options
    end

    def parse
      ParsedDocument.new(@url, parsed_data)
    end

    def parsed_data
      @data = {}
    end
  end
end
