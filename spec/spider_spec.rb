require "spec_helper"

describe Trawler::Spider do
  let(:spider) { Trawler::Spider.new("www.cats.com") }

  it "assigns the url" do
    expect(spider.instance_variable_get("@url")).to eq "www.cats.com"
  end

  describe "#call" do
    it "gets the webpage from the url" do
      VCR.use_cassette("crawl_test") do
        expect(spider.call).to be_a StringIO
      end
    end
  end

  describe "#full_url" do
    it "joins the url and the protocol" do
      expect(spider.full_url).to eq "http://www.cats.com"
    end
  end
  
  describe "#protocol" do
    it "returns 'http://' if no protocol is found" do
      spider = Trawler::Spider.new("www.cats.com")
      expect(spider.protocol).to eq "http://"
    end

    %w( http:// https://).each do |protocol|
      it "returns '' if #{protocol} is present" do
        spider = Trawler::Spider.new("#{protocol}www.cats.com")
        expect(spider.protocol).to eq ""
      end
    end
  end
end
