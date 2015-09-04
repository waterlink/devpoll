require "amethyst/amethyst/support"
require "amethyst/amethyst/http"

module Devpoll
  module Handlers
    class PostAnswer
      BY_REGEX = %r{^/polls/([^/]+)/answers/?$}

      def self.matches?(method, path)
        method == "POST" &&
          path.match(BY_REGEX)
      end

      getter request, response, slug, params, value
      def initialize(r)
        @request = Amethyst::Http::Request.new(r)
        @slug = request.path.match(BY_REGEX).not_nil![1]
        @params = request.request_parameters
        @value = params["value"]

        @response = Amethyst::Http::Response.new(302, "Found", HTTP::Headers{"Location" => "/polls/#{slug}"})
      end

      def call
        return not_found unless poll && answer && can_vote?
        vote
        set_vote_cookie
        redirect_to_poll
      end

      def redirect_to_poll
        response.build
      end

      def poll
        @_poll ||= Models::Poll.find_by_slug(slug)
      end

      def answer
        @_answer ||= Models::Answer.find_by_value(value, within: poll)
      end

      def answer!
        answer.not_nil!
      end

      def can_vote?
        request.cookies["voted_on_#{slug}"]? != "true"
      end

      def not_found
        HTTP::Response.new(404, "Not found", HTTP::Headers{"Content-Type": "text/plain"})
      end

      def vote
        # FIXME: give transaction capabilities to model/adapter
        #answer!.in_transaction do
          answer!.voted += 1
          answer!.update
        #end
      end

      def set_vote_cookie
        response.cookie("voted_on_#{slug}", "true")
      end
    end
  end
end
