require "spec_helper"

describe Trawler::Spider do
  let(:spider) { Trawler::Spider.new("www.cats.com") }

  it "assigns the url" do
    expect(spider.instance_variable_get("@url")).to eq "www.cats.com"
  end

  describe "#full_url" do
    context "without a full scheme" do
      it "adds the protocol to the url" do
        expect(spider.full_url).to eq "http://www.cats.com" 
      end
    end

    context "with a full scheme" do
      let(:spider) { Trawler::Spider.new("https://foo.com") }
      it "returns the url" do
        expect(spider.full_url).to eq "https://foo.com" 
      end
    end
  end

  describe "#get_page" do
    it "returns a string" do
      VCR.use_cassette("trawl_page") do
        expect(spider.get_page).to be_a StringIO
      end
    end
  end

  describe "#call" do
    let(:crawled_spider) do
      VCR.use_cassette("trawl_page") do
        spider.call
      end
    end

    it "returns the object" do
      expect(crawled_spider).to be_a Trawler::Spider
    end

    it "has the full_url" do
      expect(crawled_spider.full_url).to eq "http://www.cats.com"
    end

    it "has the page" do
      expect(crawled_spider.page).not_to be_nil
    end
  end
end
