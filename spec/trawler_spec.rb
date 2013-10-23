require "spec_helper"

describe Trawler do
  describe "#fetch" do
    let(:haul) do
      VCR.use_cassette("shaming") do
        Trawler.fetch("http://www.dogshaming.com/")
      end
    end

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
