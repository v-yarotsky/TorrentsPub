require 'trackers/torrents_by'

module TorrentsPub
  class Tracker
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :login, String
    property :password, String
    property :rules, Json, default: []

    class TorrentFilter
      def initialize(rules)
        @rules = rules
      end

      def filter(torrents)
        torrents
      end
    end

    def torrents
      tracker_sections = rules.map { |r| r["tracker_section"] }
      @tracker = Trackers::TorrentsBy.new(login, password, tracker_sections, '')
      @filter = TorrentFilter.new(rules)
      @filter.filter @tracker.torrents
    end
  end
end


