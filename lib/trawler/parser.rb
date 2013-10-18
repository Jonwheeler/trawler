require "nokogiri"
require 'hashie/rash'

module Trawler
  class Parser
    attr_reader :url

    def initialize(options)
      @page = options[:page]
      @url = options[:url]
      @min_image_size = options[:image_size] 
      @data = Hashie::Rash.new
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

    def scrape_meta_data
      document.xpath("//meta").each do |element|
        get_meta_data_name_or_property(element)
      end
    end

    def get_meta_data_name_or_property(element)
       name_or_property = element.attributes["name"] ? "name" : (element.attributes["property"] ? "property" : nil)
       content_or_value = element.attributes["content"] ? "content" : (element.attributes["value"] ? "value" : nil)

       if !name_or_property.nil? && !content_or_value.nil?
         @data.meta.name[element.attributes[name_or_property].value.downcase] = element.attributes[content_or_value].value
       end

    end

    def method_missing(method_name)
      if method_name.to_s =~ /^meta_(.*)/
        key = $1

        #special treatment for opengraph (og:) and twitter card (twitter:) tags
        key.gsub!("_",":") if key =~ /^og_(.*)/ || key =~ /^twitter_(.*)/
        
        scrape_meta_data
        
        @data.meta.name && (@data.meta.name[key.downcase]) || (@data.meta.property && @data.meta.property[key.downcase])
      else
        super
      end
    end
  end
end
