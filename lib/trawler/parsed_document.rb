module Trawler
  class ParsedDocument
    attr_reader :url, :data

    def initialize(host, data)
      @url  = host
      @data = data
    end

    def title
      data.title
    end
  
    def video
      data.video
    end

    def images
      data.images
    end

    def description
      data.description
    end

    def raw_data
      @raw_data ||= data.document
    end
  end
end
