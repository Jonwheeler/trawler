require "spec_helper"

describe Trawler::Parser do

  context "image rich page" do
    let(:document) { fixture("dogshaming.html") }
    let(:parser) { Trawler::Parser.new("www.foo.com", document) }

    
    describe "#title" do
      it "parses the page title" do
        expect(parser.title).to eq ""
      end
    end

  end
end
