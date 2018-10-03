# Faraday::Request::Timer

A gem for timing Faraday requests. Faraday has an
[instrumentation middleware][instrumentation], but it uses
ActiveSupport::Notifications.

```ruby
ActiveSupport::Notifications.subscribe("request.faraday") do |name, starts, ends, _, env|
  url      = env[:url]
  duration = ends - starts

  puts "The request to #{url} took #{duration} seconds."
end
```

That's great if you want to log request times out-of-band, but not so useful if
you need to do something specific with that time in-band, right after the
request was made. For that you need Faraday::Request::Timer.

## Installation

Add this line to your application's Gemfile:

    gem 'faraday-request-timer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faraday-request-timer

## Usage

```ruby
connection = Faraday::Connection.new do |builder|
  builder.request :timer # timeout: option available
  builder.adapter Faraday.default_adapter
end

response = connection.get("https://canaryup.com")
response.env[:duration]
# => 0.130454
```

## Contributing

1. Fork it ( http://github.com/canaryup/faraday-request-timer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[instrumentation]: https://github.com/lostisland/faraday/blob/master/lib/faraday/request/instrumentation.rb
