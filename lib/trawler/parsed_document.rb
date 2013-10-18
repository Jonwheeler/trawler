module Trawler
  class ParsedDocument
    attr_reader :data

    def initialize(data, options = {})
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
