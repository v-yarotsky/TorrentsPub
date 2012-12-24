require 'torrents_pub/scrape/trackers'
require 'torrents_pub/torrent'

module TorrentsPub
  class Tracker
    attr_reader :name

    ##
    # :tracker_sections - [Struct(:name, :category)]
    def initialize(options)
      @tracker_type, @name, @login, @password, @tracker_sections = options.values_at(:tracker_type, :name, :login, :password, :tracker_sections)
    end


    def fetch_torrents
      @tracker = Scrape::AVAILABLE_TRACKERS.fetch(@tracker_type).new(@login, @password, @tracker_sections.map(&:tracker_section), '')
      @tracker.torrents.each do |torrent_attributes|
        tracker_section = @tracker_sections.detect { |t| t.tracker_section == torrent_attributes[:tracker_section] }
        next unless tracker_section && tracker_section.match?(torrent_attributes)
        torrent = Torrent.first_or_new(link: torrent_attributes.delete(:link))
        torrent.tracker = @tracker_type
        torrent.category = tracker_section.category
        torrent.attributes = torrent_attributes
        torrent.save!
      end
    end
  end
end


