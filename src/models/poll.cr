module Devpoll
  module Models
    class Poll
      def self.find_by_slug(slug)
        return unless slug == "test"
        Poll.new("Test poll", "test")
      end

      getter title, slug
      def initialize(@title, @slug)
      end
    end
  end
end
