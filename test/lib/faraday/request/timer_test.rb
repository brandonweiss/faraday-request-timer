require File.expand_path("../../../../test_helper", __FILE__)

describe Faraday::Request::Timer do

  after do
    Time.unstub(:now)
  end

  it "registers itself as request middleware" do
    Faraday::Request.lookup_middleware(:timer).must_equal Faraday::Request::Timer
  end

  it "times a request" do
    Time.stubs(:now).returns(Time.utc(2014, 1, 1, 6, 0, 0))

    connection = Faraday::Connection.new("http://example.net") do |builder|
      builder.request :timer

      builder.adapter :test do |stubs|
        stubs.get("/") {
          Time.stubs(:now).returns(Time.utc(2014, 1, 1, 6, 0, 2))
          [200, {}, ""]
        }
      end
    end

    response = connection.get("/")
    response.env[:duration].must_equal 2
  end

  describe "timeout" do
    it "timeout a request" do
      Time.stubs(:now).returns(Time.utc(2014, 1, 1, 6, 0, 0))

      connection = Faraday::Connection.new("http://example.net") do |builder|
        builder.request :timer, timeout: 3

        builder.adapter :test do |stubs|
          stubs.get("/") {
            Time.stubs(:now).returns(Time.utc(2014, 1, 1, 6, 0, 5))
            [200, {}, ""]
          }
        end
      end

      proc { connection.get("/") }.must_raise Faraday::TimeoutError
    end

    it "should not timeout a request" do
      Time.stubs(:now).returns(Time.utc(2014, 1, 1, 6, 0, 0))

      connection = Faraday::Connection.new("http://example.net") do |builder|
        builder.request :timer, timeout: 3

        builder.adapter :test do |stubs|
          stubs.get("/") {
            Time.stubs(:now).returns(Time.utc(2014, 1, 1, 6, 0, 2))
            [200, {}, ""]
          }
        end
      end

      response = connection.get("/")
      response.env[:duration].must_equal 2
    end
  end

end
