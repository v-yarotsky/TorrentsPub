require 'forwardable'
require 'torrents_pub/scrape/agent'
require 'torrents_pub/core_ext'

module TorrentsPub
  module Scrape
    AVAILABLE_TRACKERS = {}

    class Tracker
      extend Forwardable

      def_delegator :scraper, :fetch_torrents
      def_delegator :downloader, :download_torrent!

      inheritable_class_attribute :agent_creator, :default => proc { Agent.new }

      def self.inherited(klass)
        name = (klass.name || "Tracker#{klass.object_id}").gsub(/^.*::/, '').gsub(/Tracker$/, '')
        AVAILABLE_TRACKERS[name] = klass
      end

      def initialize(*args)
        @torrents = []
      end

      def refresh_torrents!
        @torrents = fetch_torrents
      end

      def torrents
        refresh_torrents! if @torrents.empty?
        @torrents.dup
      end

      private

      abstract_method :scraper
      abstract_method :downloader

      def agent
        @agent ||= self.class.agent_creator.call
      end
    end
  end
end

