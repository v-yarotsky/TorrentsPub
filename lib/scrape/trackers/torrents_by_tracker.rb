require 'scrape/tracker'
require 'scrape/trackers/torrents_by/authentication_proxy'
require 'scrape/trackers/torrents_by/scraper'
require 'scrape/trackers/torrents_by/torrent_downloader'

module Scrape
  module Trackers

    class TorrentsByTracker < Tracker
      def initialize(login, password, tracker_categories, directory)
        super
        @login              = login
        @password           = password
        @tracker_categories = tracker_categories
        @directory          = directory
      end

      private

      def scraper
        @scraper ||= wrap_with_authentication(TorrentsByTracker::Scraper.new(agent, @tracker_categories))
      end

      def downloader
        @downloader ||= wrap_with_authentication(TorrentsByTracker::TorrentDownloader.new(agent, @directory))
      end

      def wrap_with_authentication(subject)
        TorrentsByTracker::AuthenticationProxy.new(subject, agent, @login, @password)
      end
    end

  end
end

