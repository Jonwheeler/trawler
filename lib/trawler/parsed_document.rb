module Trawler
  class ParsedDocument
    attr_reader :host

    def initialize(data, options = {})
      @host = data.delete(:host)
      @data = data
    end

    def title
      data[:title]
    end
  
    def videos
      []
    end

    def images
      []
    end

    def description
      data[:description]
    end
  end
end
