module Devpoll
  module Handlers
    class GetPoll
      BY_REGEX = %r{^/polls/([^/]+)/?$}

      def self.matches?(method, path)
        method == "GET" &&
          path.match(BY_REGEX)
      end

      getter request, slug
      def initialize(@request)
        @slug = request.path.match(BY_REGEX).not_nil![1]
      end

      def call
        return not_found unless poll
        HTTP::Response.new(200, "Got poll: #{poll.inspect}", HTTP::Headers{"Content-Type": "text/plain"})
      end

      def poll
        @_poll ||= Models::Poll.find_by_slug(slug)
      end

      def not_found
        HTTP::Response.new(404, "Unable to find poll: #{slug}", HTTP::Headers{"Content-Type": "text/plain"})
      end
    end
  end
end
