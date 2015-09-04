module Devpoll
  module Models
    class Answer < ActiveRecord::Model
      name Answer

      adapter configured
      table_name answers

      query_level :private

      primary id      :: Int
      field   poll_id :: Int
      field   value   :: String
      field   voted   :: Int

      def self.find_by_value(value, within = nil)
        return unless within
        where((criteria("poll_id") == within.id)
          .and(criteria("value") == value))
          .first?
      end

      def self.within(poll)
        return [] of Answer unless poll
        where(criteria("poll_id") == poll.id)
      end
    end
  end
end
