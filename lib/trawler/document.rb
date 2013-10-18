module Trawler
  class Document
    def initialize(url, options = {}) 
      @url    = url
      @parser = options.fetch(:parser, Parser)
      @spider = options.fetch(:spider, Spider)
      @image  = options.fetch(:image_size, "100")
    end

    def parse
      ParsedDocument.new(doc.full_url, parsed_data)
    end

    def parsed_data
      Parser.new(page: doc.page, url: doc.full_url, image_size: @image)
    end

    def doc
      @page ||= @spider.new(@url).call
    end
  end
end
