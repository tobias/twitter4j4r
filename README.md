# Twitter4j4r

A thin, woefully inadequate wrapper around [twitter4j](http://twitter4j.org/)
that currently only supports the stream api with keywords. It will only work
under JRuby.

## Installation

Add this line to your application's Gemfile:

    gem 'twitter4j4r'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twitter4j4r

## Usage

The api is inspired by [tweetstream](https://github.com/intridea/tweetstream/):

    @client = Twitter4j4r::Client.new(:consumer_key => 'ABC123',
                                      :consumer_secret => 'ABC234',
                                      :access_token => 'ABC345',
                                      :access_secret => 'ABC456')
    
    @client.on_exception do |exception|
      puts "An error occurred - #{exception.message}"
    end
    
    @client.track('bieber') do |tweet|
      puts "#{tweet.user.screen_name} says #{tweet.text}"
    end

    # some time later
    @client.stop

Blocks passed to `track` and `on_exception` can accept optionally accept
a second argument that will be the client instance (similar to tweetstream):

    @client.track('bieber') do |tweet, client|
      if tweet.text =~ /marry me/
        puts "grody"
        client.stop
      else
        puts "#{tweet.user.screen_name} says #{tweet.text}"
      end
    end

## Why?

Because tweetstream uses EventMachine, and EM doesn't support TLS
under JRuby, so is unusable. 

Thanks to [Marek Jelen](https://github.com/marekjelen) for the inspiration.

## Isn't twitter4j4r a crappy name?

Yes! But I was a hair away from naming it `twitter4j4r4u-and-me`, so take
what you're given.

## Changelog
 [changelog](CHANGELOG.md)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright 2012 Tobias Crawley

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
