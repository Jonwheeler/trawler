module Trawler
  class ParsedDocument
    attr_reader :host

    def initialize(url, data, options = {})
      @host = url
      @data = data
    end

    def title
    end
  
    def videos
      []
    end

    def images
      []
    end

    def description
      []
    end
  end
end
