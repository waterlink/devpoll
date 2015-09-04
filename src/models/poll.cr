module Devpoll
  module Models
    class Poll < ActiveRecord::Model
      name Poll

      adapter configured
      table_name polls

      query_level :private

      primary id      :: Int
      field   slug    :: String
      field   content :: String

      def self.find_by_slug(slug)
        where(criteria("slug") == slug).first?
      end
    end
  end
end
