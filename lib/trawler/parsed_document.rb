module Trawler
  class ParsedDocument
    attr_reader :host, :data

    def initialize(host, data)
      @host = host
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
