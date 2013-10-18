require "spec_helper"

describe Trawler::Parser do
  context "image rich page" do
    let(:page) { fixture("sample_pages/tumblr.html") }
    let(:parser) do
      Trawler::Parser.new(
        page:       page, 
        url:        "http://www.foo.com", 
        image_size: "100"
      )
    end

    describe "#title" do
      it "parses the page title" do
        expect(parser.title).to eq "DogShaming"
      end
    end

    it "gets the meta data" do
      puts parser.scrape_meta_data
    end
  end
end
