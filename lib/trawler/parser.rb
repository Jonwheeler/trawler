require "nokogiri"

module Trawler
  class Parser
    attr_reader :url

    def initialize(options)
      @page = options[:page]
      @url = options[:url]
      @min_image_size = options[:image_size] 
    end

    def title
      html_title ? html_title : meta_title
    end

    def description
    end

    def images
      []
    end

    def videos
      []
    end

    def document 
      @document ||= Nokogiri::HTML(@page) 
    end

    def html_title
      document.css("title").inner_text rescue nil
    end

    def meta_title
      
    end

    def scrape_meta_data
      document.xpath("//meta").each do |element|
        puts element
      end
    end
  end
end
