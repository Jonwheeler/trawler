require "open-uri"

module Trawler
  class Spider
    def initialize(url)
      @url = url
    end

    def call
      open(full_url)
    end

    def full_url
      "#{protocol}#{@url}"
    end

    def protocol
      /(http:\/\/|https:\/\/)/ =~ @url ? "" : "http://"
    end
  end
end
