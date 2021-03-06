require 'scrape/tracker'
require 'scrape/trackers/rutracker_org/agent'
require 'scrape/trackers/rutracker_org/authentication_proxy'
require 'scrape/trackers/rutracker_org/scraper'
# require 'scrape/trackers/rutracker_org/torrent_downloader'


module Scrape
  module Trackers

    class RutrackerOrgTracker < Tracker
      self.agent_creator = proc { Agent.new }

      def initialize(login, password, tracker_categories, directory)
        super
        @login              = login
        @password           = password
        @tracker_categories = tracker_categories
        @directory          = directory
      end

      private

      def scraper
        @scraper ||= wrap_with_authentication(RutrackerOrgTracker::Scraper.new(agent, @tracker_categories))
      end

      def downloader
        @downloader ||= wrap_with_authentication(RutrackerOrgTracker::TorrentDownloader.new(agent, @directory))
      end

      def wrap_with_authentication(subject)
        RutrackerOrgTracker::AuthenticationProxy.new(subject, agent, @login, @password)
      end
    end

  end
end

