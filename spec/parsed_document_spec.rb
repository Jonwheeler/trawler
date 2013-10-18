require "spec_helper"

describe Trawler::ParsedDocument do

  let(:data)  { double("PARSER", images: ["foo"], title: "foobar", video: "bar", description: "foobarbaz", document: "") }
  let(:doc)  { Trawler::ParsedDocument.new("www.cats.com", data) }

  it "sets the url" do
    expect(doc.url).to eq "www.cats.com"
  end

  it "has images" do
    expect(doc.images).to be_a Array
    expect(doc.images).to include "foo"
  end

  it "has a title" do
    expect(doc.title).to eq "foobar"
  end

  it "has a video" do
    expect(doc.video).to eq "bar"
  end

  it "has a description" do
    expect(doc.description).to eq "foobarbaz"
  end

  it "has the raw data" do
    expect(doc.raw_data).to eq ""
  end
end
