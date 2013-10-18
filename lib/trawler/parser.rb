require "nokogiri"
require "hashr"

module Trawler
  class Parser
    attr_reader :url
    attr_reader :meta_data

    def initialize(options)
      @page           = options[:page]
      @url            = options[:url]
      @min_image_size = options[:image_size] 
      @meta_data      = Hashr.new
    end

    def title
      meta_title.nil? ? html_title : meta_title
    end

    def description
      meta_description.nil? ? html_description : meta_description
    end

    def images
      images = [meta_image]
      images << find_images
      images.flatten!
      images = images.select { |img| !img.nil? }.select { |s| !s.empty? }
      images.flatten.map! { |img| img.strip }
      images.map! { |img| normalize_url(img) }
      images.uniq
    end

    def normalize_url(uri)
      if uri =~ /^\w*\:/i
        return uri
      else
        Addressable::URI.join(url, uri).normalize.to_s
      end
    rescue URI::InvalidURIError, Addressable::URI::InvalidURIError => e
      add_fatal_error "Link parsing exception: #{e.message}" and nil
    end

    def video
      meta_video
    end

    def document 
      @document ||= Nokogiri::HTML(@page) 
    end

    private

    def html_title
      document.css("title").inner_text rescue nil
    end

    def html_description
      first_long_paragraph = document.search("//p[string-length() >= 150]").first
      first_long_paragraph ? first_long_paragraph.text : ''
    end

    def find_images
      images = document.css('img')
      images = images.select { |img| !img[:alt].nil? && !img[:alt].empty? }
      images.reject! { |img| img[:alt] =~ /(loading|spinner)/i }
      images.reject! { |img| img[:class] =~ /(loading|spinner|icon)/i }
      images.reject! { |img| img[:width] && img[:width] < @min_image_size }
      buzzfeed_images = images.map { |i| i["rel:bf_image_src"].to_s }
      images.reject! { |img| img[:src] =~ /(background|icons|icon)/i }
      images.map! { |img| img[:src] }
      images << buzzfeed_images
      images.flatten.uniq
    end

    def meta_title
      scrape_meta_data
      meta_data.title rescue nil
    end

    def meta_description
      scrape_meta_data
      meta_data.description rescue nil
    end

    def meta_video
      scrape_meta_data
      meta_data.video rescue nil
    end

    def meta_image
      scrape_meta_data
      meta_data.image rescue nil
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
        meta_data[element.attributes[name_or_property].value.downcase.gsub(/(og:|twitter:)/, "").gsub(/:/, "_").to_sym] = element.attributes[content_or_value].value
      end
    end
  end
end
