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
      ParsedDocument.new(@url, parsed_data)
    end

    def parsed_data
      @parser.new(doc).call
    end

    def doc
      @page ||= fetch_document
    end

    def fetch_document
      @document ||= Nokogiri::HTML(@spider.new(@url).call)
    end
  end
end
