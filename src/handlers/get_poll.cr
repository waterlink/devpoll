require "ecr/macros"

module Devpoll
  module Handlers
    class GetPoll
      ecr_file "./src/views/get_poll.ecr"

      BY_REGEX = %r{^/polls/([^/]+)/?$}

      def self.matches?(method, path)
        method == "GET" &&
          path.match(BY_REGEX)
      end

      getter request, slug
      def initialize(r)
        @request = Amethyst::Http::Request.new(r)
        @slug = request.path.match(BY_REGEX).not_nil![1]
      end

      def call
        return not_found unless poll
        HTTP::Response.new(200, to_s, HTTP::Headers{"Content-Type": "text/html"})
      end

      def can_vote?
        request.cookies["voted_on_#{slug}"]? != "true"
      end

      def poll
        @_poll ||= Models::Poll.find_by_slug(slug)
      end

      def poll!
        poll.not_nil!
      end

      def answers
        @_answers ||= Models::Answer.within(poll)
      end

      def not_found
        HTTP::Response.new(404, "Unable to find poll: #{slug}", HTTP::Headers{"Content-Type": "text/plain"})
      end
    end
  end
end
