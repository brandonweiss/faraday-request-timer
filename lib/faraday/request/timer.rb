module Faraday
  class Request::Timer < Faraday::Middleware

    Faraday::Request.register_middleware :timer => self

    def initialize(app, options = {})
      super(app)
      @timeout = options[:timeout]
    end

    def call(env)
      started_at = Time.now
      app        = @app.call(env)
      ended_at   = Time.now

      duration = ended_at - started_at
      app.env[:duration] = duration
      if @timeout && duration > @timeout
        raise Faraday::TimeoutError
      end

      app
    end

  end
end
