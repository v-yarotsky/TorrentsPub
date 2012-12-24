require 'mechanize'

module TorrentsPub
  module Scrape
    class Agent
      extend Forwardable

      def_delegators :page, :form_with, :link_with, :search
      def_delegators :@agent, :get_file

      def initialize
        @agent = Mechanize.new
        @agent.pluggable_parser['application/x-bittorrent'] = Mechanize::Download
      end

      def visit_url(url)
        @agent.get(url)
      end

      def download(url)
        @agent.get(url)
      end

      def page
        @agent.page
      end
    end
  end
end

