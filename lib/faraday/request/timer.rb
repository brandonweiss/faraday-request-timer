module Faraday
  class Request::Timer < Faraday::Middleware

    Faraday::Request.register_middleware :timer => self

      def call(env)
        started_at = Time.now
        app        = @app.call(env)
        ended_at   = Time.now

        app.env[:duration] = ended_at - started_at
        app
    end

  end
end
