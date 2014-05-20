require "rubygems"
require "bundler"
Bundler.require

require "minitest/autorun"
require "mocha/setup"

class Minitest::Spec

  def connection
    Faraday::Connection.new("http://example.net") do |builder|
      builder.request :timer

      builder.adapter :test do |stubs|
        yield(stubs)
      end
    end
  end

end
