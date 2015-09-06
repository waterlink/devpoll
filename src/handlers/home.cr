require "ecr/macros"

module Devpoll
  module Handlers
    class Home
      ecr_file "./src/views/home.ecr"

      def self.matches?(method, path)
        method == "GET" &&
          path == "/"
      end

      getter request
      def initialize(@request)
      end

      def call
        HTTP::Response.new(200, to_s, HTTP::Headers{"Content-Type": "text/html"})
      end

      def polls
        Models::Poll.find_all
      end
    end
  end
end
