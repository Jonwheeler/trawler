require "nokogiri"

module Trawler
  class Document
    def initialize(url, options = {}) 
      @url    = url
      @parser = options[:parser]     || Parser
      @spider = options[:spider]     || Spider
      @image  = options[:image_size] || "100px"
    end

    def parse
      ParsedDocument.new(parsed_data, @image_size)
    end

    def parsed_data
      @parser.new(@url, doc).call
    end

    def doc
      @page ||= @spider.new(@url).call
    end

    def fetch_document
      @spider.new(@url).call
    end
  end
end
