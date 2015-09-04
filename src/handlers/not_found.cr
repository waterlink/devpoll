module Devpoll
  module Handlers
    class NotFound
      def self.matches?(method, path)
        true
      end

      def initialize(@request)
      end

      def call
        HTTP::Response.new(404, "Not Found", HTTP::Headers{"Content-Type": "text/plain"})
      end
    end
  end
end
