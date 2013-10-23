require "open-uri"

module Trawler
  class Spider
    attr_reader :page, :full_url

    def initialize(url)
      @url = url
    end

    def call
      get_page   
      self
    end

    def full_url
      @full_url ||= URI.parse(@url).scheme.nil? ? 'http://' + @url : @url
    end

    def get_page
      @page ||= open(full_url).read
    end
  end
end
