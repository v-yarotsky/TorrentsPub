# encoding: utf-8
require 'scrape/agent'
require 'scrape/trackers/xbbt_scraper'
require 'uri'

module Scrape
  module Trackers

    class RutrackerOrgTracker < Tracker

      class Scraper < XbbtScraper
        self.human_name  = "Rutracker.org"
        self.site_url    = "http://rutracker.org"

        TRACKER_URL = URI.join(self.site_url, "/forum/tracker.php")

        class TorrentParser < XbbtScraper::TorrentParser
          def tracker_section; text_at_css("a.gen");               end
          def title;           text_at_css("td.row4.med.tLeft a"); end
          def seeders;         text_at_css("td.seedmed b").to_i;   end
          def link;            href_at_css("a.tr-dl");             end
          def tracker_link;    href_at_css('td.row4.med.tLeft a'); end

          def size
            size_str = text_at_css("a.tr-dl")
            parse_size(size_str)
          end
        end

        private

        def set_up_filters
          @agent.visit_url(TRACKER_URL)
          @agent.form_with(action: "tracker.php") do |form|           #search form
            available_tracker_sections = Hash[form.field('f[]').options.map { |opt| [opt.text.gsub(" |- ", "").chop, opt] }]
            @tracker_sections.each do |section|
              option = available_tracker_sections[section] or next
              debug_message("Section: #{section}")
              option.tick
            end
            form.field('tm').option_with(:text => /сегодня/i).select  #period dropdown
            form.checkbox('oop').check                                #only open
          end.submit
        end
      end

    end

  end
end

