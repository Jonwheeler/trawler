module Trawler
  class Parser
    def initialize(raw_data)
      @raw_data = raw_data
    end

    def call
      parse_document
      build_structure
    end

    def parse_document
    end

    def build_structure
      {
        host:        "www.cats.com",
        title:       "catty cat cat",
        description: "cats and cats and cat and cats",
        images:       [],
        videos:       []
      }
    end
  end
end
