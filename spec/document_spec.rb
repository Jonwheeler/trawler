require "spec_helper"

describe Trawler::Document do
  let(:doc) { Trawler::Document.new("http://www.dogshaming.com") }

  before do
    Trawler::Spider.any_instance.stub(:call) { fixture("dogshaming.html") }
  end

  it "requires a URL" do
    expect{ Trawler::Document.new }.to raise_error
  end

  describe "#fetch_document" do
    it "returns a nokogiri document" do
      expect(doc.fetch_document).to be_a Nokogiri::HTML::Document
    end
  end
end
