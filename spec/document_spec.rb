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
    it "returns a document from the url as a string" do
      expect(doc.doc).to be_a String
    end
  end
end
