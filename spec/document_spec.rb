require "spec_helper"

describe Trawler::Document do
  let(:document) { Trawler::Document.new("http://www.dogshaming.com") }

  before do
    Trawler::Spider.any_instance.stub(:get_page) { fixture("sample_pages/tumblr.html") }
  end

  it "requires a URL" do
    expect{ Trawler::Document.new }.to raise_error
  end

  describe "#doc" do
    it "returns the crawled document object" do
      expect(document.doc).to be_a Trawler::Spider
    end
  end

  describe "#parse" do
    it "returns a parsed document" do
      expect(document.parse).to be_a Trawler::ParsedDocument
    end
  end

  describe "#parsed_data" do
    it "returns a parse object" do
      expect(document.parsed_data).to be_a Trawler::Parser
    end
  end
end
