require 'slapjack/trackers'
require 'torrents_pub/torrent'

module TorrentsPub
  class Tracker
    include DataMapper::Resource

    property :id, Serial
    property :tracker_type, String, required: true
    property :login, String
    property :password, String
    property :rules, Json, default: []

    def self.available_types
      Slapjack::AVAILABLE_TRACKERS.keys
    end

    class Rule
      attr_reader :category, :tracker_section, :required_keywords, :denied_keywords, :min_seeders

      def initialize(attributes)
        @attributes = attributes
        @category, @tracker_section, @required_keywords, @denied_keywords, @min_seeders = 
          attributes.values_at("category", "tracker_section", "required_keywords", "denied_keywords", "min_seeders")
      end

      def to_json(*args)
        @attributes.to_json(*args)
      end
    end

    def rules
      attribute_get(:rules).map(&Rule.method(:new))
    end

    def tracker_sections
      rules.map(&:tracker_section)
    end

    def categories
      rules.each_with_object({}) { |rule, result| result[rule.tracker_section] = rule.category }
    end

    def fetch_torrents
      @tracker = Slapjack::AVAILABLE_TRACKERS.fetch(tracker_type).new(login, password, tracker_sections, '')
      @tracker.torrents.each do |torrent_attributes|
        torrent = Torrent.first_or_new(link: torrent_attributes.delete(:link))
        torrent.tracker = tracker_type
        torrent.category = categories[torrent_attributes[:tracker_section]]
        torrent.attributes = torrent_attributes
        torrent.save!
      end
    end
  end
end


