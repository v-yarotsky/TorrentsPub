require 'slapjack/trackers'
require 'torrents_pub/torrent'

module TorrentsPub
  class Tracker
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :login, String
    property :password, String
    property :rules, Json, default: []

    class Rule
      attr_reader :category, :tracker_section, :required_keywords, :denied_keywords, :min_seeders

      def initialize(attributes)
        @category, @tracker_section, @required_keywords, @denied_keywords, @min_seeders = 
          attributes.values_at("category", "tracker_section", "required_keywords", "denied_keywords", "min_seeders")
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
      @tracker = Slapjack::Trackers::TorrentsByTracker.new(login, password, tracker_sections, '')
      @tracker.torrents.each do |torrent_attributes|
        torrent = Torrent.first_or_new(link: torrent_attributes.delete(:link))
        torrent.tracker = name
        torrent.category = categories[torrent_attributes[:tracker_section]]
        torrent.attributes = torrent_attributes
        torrent.save!
      end
    end
  end
end


