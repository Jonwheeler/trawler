require "spec_helper"

describe Trawler::ParsedDocument do

  let(:data) do
    {
      host:        "www.cats.com",
      title:       "catty cat cat",
      description: "cats and cats and cat and cats",
      images:       [],
      videos:       []
    }
  end

  let(:doc)  { Trawler::ParsedDocument.new("www.cats.com", data) }

  it "sets the host" do
    expect(doc.host).to eq "www.cats.com"
  end
end
