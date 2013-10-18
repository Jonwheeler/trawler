require "nokogiri"

module Trawler
  class Parser
    def initialize(url, document)
      @url      = url
      @document = document
    end

    def call
      parse_document
    end

    def parse_document
      {
        host:        @url,
        title:       title,
        description: description,
        images:      images,
        videos:      videos
      }
    end

    def title
      document.css('title').inner_text rescue nil
    end

    def description
    end

    def images
      []
    end

    def videos
      []
    end
  end
end
