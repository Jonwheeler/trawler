require "open-uri"

module Trawler
  class Spider
    def initialize(url)
      @url = url
    end

    def call
      open(@url) 
    end
  end
end
