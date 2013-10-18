# Trawler

Trawl the web for meta tags.

## Installation

Add this line to your application's Gemfile:

    gem 'trawler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trawler

## Usage

Trawler is designed to be simple to use. Give the Trawler a URL and some options
and it will bring back a catch of Images, Meta Descriptions and Video URLS in a
ParsedDocument object.

```ruby
  doc = Trawler.fetch("www.foobar.com") 
  doc.url         # => "http://www.foobar.com"
  doc.description # => "Descriptive meta tag"
  doc.title       # => "Foobar.com The place of Foo"
  doc.images      # => [
                  #      http://www.foobar.com/assets/bar.png,
                  #      http://www.foobar.com/assets/baz.jpg,
                  #      http://www.foobar.com/assets/bat.gif
                  #     ]
  doc.video       # => [
                  #      http://www.vimeo.com/354357349
                  #     ]
```

## Testing

```
 rspec/
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
