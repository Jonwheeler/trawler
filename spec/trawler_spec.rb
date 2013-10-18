require "spec_helper"

describe Trawler do
  describe "#fetch" do
    before do
      Trawler::Spider.any_instance.stub(:get_page) { fixture("sample_pages/tumblr.html") }
    end
    
    let(:haul) { Trawler.fetch("http://www.dogshaming.com/") }

    it "returns a ParsedDocument" do
      expect(haul).to be_a(Trawler::ParsedDocument)
    end

    it "has the original url" do
      expect(haul.url).to eq("http://www.dogshaming.com/")
    end

    [:video, :images, :description, :title].each do |attr|
      it "has #{attr}" do
        expect(haul).to respond_to(attr)
      end
    end

    it "returns an array of images" do
      expect(haul.images).to be_a Array
    end
  end
end
