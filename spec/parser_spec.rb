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
        expect(parser.title).to eq "Dogshaming"
      end
    end
    
    describe "#description" do
      it "parses the description from the meta data" do
        expect(parser.description).not_to be_empty
      end
    end
    
    describe "#videos" do
      it "returns nil if no videos are found" do
        expect(parser.video).to be_nil
      end
    end

    describe "#images" do
      it "returns an array of images" do
        expect(parser.images).to be_a Array
      end

      it "all the images that are larger than the min image size" do
        expect(parser.images.size).to eq 10
      end
    end
  end

  context "video page" do
    let(:page) { fixture("sample_pages/youtube.html") }
    let(:parser) do
      Trawler::Parser.new(
        page:       page, 
        url:        "http://www.foo.com", 
        image_size: "100"
      )
    end

    it "gets the title" do
      expect(parser.title).to eq "Single Page Web Applications: JavaScript End-to-End (The Hard Stuff)"
    end

    it "gets the video" do
      expect(parser.video).to eq "http://www.youtube.com/v/OrIFaWJ9Glo?version=3&autohide=1"
    end

    it "gets the description" do
      expect(parser.description).to eq "In the old days, when websites were steam powered and exploded regularly, the web was simple, but slow. As it evolved it became more powerful, but harder on ..."
    end

    it "gets the images" do
      expect(parser.images).to include "http://i1.ytimg.com/vi/OrIFaWJ9Glo/maxresdefault.jpg"
    end

    it "gets an image as the placeholder for the video" do
      expect(parser.video_still).to eq "http://i1.ytimg.com/vi/OrIFaWJ9Glo/maxresdefault.jpg"
    end
  end

  context "document style page" do
    let(:page) { fixture("sample_pages/simple.html") }
    let(:parser) do
      Trawler::Parser.new(
        page: page,
        url: "foobar",
        image_size: "100"
      )
    end

    let(:description) do
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dapibus velit in lacus mollis vehicula nec a arcu"
    end

    it "returns the description from the body of the text" do
      expect(parser.description[0..120]).to match description
    end

    it "gets the title from the html" do
      expect(parser.title).to eq "Super simple html page"
    end

    it "gets no images" do
      expect(parser.images).to be_empty
    end

    it "gets no video" do
      expect(parser.video).to be_nil
    end
  end
end
