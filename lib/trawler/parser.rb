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
        get_meta_data_name_or_property(element)
      end
    end

    def get_meta_data_name_or_property(element)
       name_or_property = element.attributes["name"] ? "name" : (element.attributes["property"] ? "property" : nil)
       content_or_value = element.attributes["content"] ? "content" : (element.attributes["value"] ? "value" : nil)

       if !name_or_property.nil? && !content_or_value.nil?
          puts "#{element.attributes[name_or_property].value.downcase} = #{element.attributes[content_or_value].value}"
       end

    end
  end
end
