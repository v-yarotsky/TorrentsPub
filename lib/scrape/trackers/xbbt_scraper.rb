# encoding: utf-8
require 'scrape/agent'
require 'scrape/scraper'
require 'uri'

module Scrape
  module Trackers

    class XbbtScraper < Scraper

      class TorrentParser
        def initialize(row, base_url = nil)
          @row      = row
          @base_url = base_url
        end

        def attributes
          [:tracker_section, :title, :link, :tracker_link, :size, :seeders].each_with_object({}) do |f, hsh|
            hsh[f] = self.send(f)
          end
        end

        private

        def href_at_css(selector)
          element = @row.at_css(selector)
          element.attr(:href) if element
        end

        def text_at_css(selector)
          element = @row.at_css(selector)
          element && element.text || ""
        end

        def form_link(href)
          if href
            @base_url.nil? ? href : URI.join(@base_url, href).to_s
          end
        end

        def parse_size(string)
          return 0 if string.nil? || string.empty?
          num = string.to_f
          uom = string[/[A-Z]{2}/]
          result = case uom
            when "GB"
              num * 1024 ** 3
            when "MB"
              num * 1024 ** 2
          end
          result || 0
        end
      end


      def initialize(agent, tracker_sections)
        @agent              = agent
        @tracker_sections = tracker_sections
      end

      def fetch_torrents
        set_up_filters
        parse_search_results
      end

      private

      def parse_search_results
        @torrents = parse_search_results_page
        until (link = @agent.link_with(:text => "След.")).nil?
          link.click
          @torrents.concat parse_search_results_page
        end
        @torrents
      end

      def parse_search_results_page
        @agent.search('.//tr[contains(@class, "tCenter")]').map { |row| parse_torrent(row) }.compact
      end

      def parse_torrent(row)
        self.class.const_get(:TorrentParser).new(row).tap { |t| debug_message("Torrent: #{t.title.slice(0, 50)}...") }.attributes
      end
    end

  end
end

