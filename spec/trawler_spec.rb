require "spec_helper"

describe Trawler do
  describe "#fetch" do

    before do
      Trawler::Spider.any_instance.stub(:call) { fixture("dogshaming.html") }
    end
    
    let(:haul) { Trawler.fetch("http://www.dogshaming.com/") }

    it "returns a ParsedDocument" do
      expect(haul).to be_a(Trawler::ParsedDocument)
    end

    it "has the original url" do
      expect(haul.host).to eq("http://www.dogshaming.com/")
    end

    [:videos, :images, :description, :title].each do |attr|
      it "has #{attr}" do
        expect(haul).to respond_to(attr)
      end
    end

    [:videos, :images].each do |attr|
      it "returns an array of #{attr}" do
        expect(haul.send(attr)).to be_a Array
      end
    end
  end
end
