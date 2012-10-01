# encoding: utf-8
require 'slapjack/agent'
require 'slapjack/tracker'
require 'slapjack/trackers/xbbt_scraper'
require 'uri'

module Slapjack
  module Trackers
    class TorrentsByTracker < Slapjack::Tracker
      class Scraper < XbbtScraper

        self.human_name  = "Torrents.by"
        self.site_url    = "http://torrents.by"

        TRACKER_URL = URI.join(self.site_url, "/forum/tracker")

        class TorrentParser < XbbtScraper::TorrentParser
          def initialize(row, base_url = URI.join(TorrentsByTracker::Scraper.site_url, '/forum/'))
            super
          end

          def tracker_section; text_at_css("a.gen");                 end
          def title;           text_at_css("td.row4.med.tLeft a b"); end
          def seeders;         text_at_css("td.seedmed b").to_i;     end

          def link
            href = href_at_css("a.tr-dl")
            form_link(href)
          end

          def tracker_link
            href = href_at_css('td.row4.med.tLeft a')
            form_link(href)
          end 

          def size
            size_str = text_at_css("a.tr-dl span.bold")
            parse_size(size_str)
          end
        end

        private

        def set_up_filters
          @agent.visit_url(TRACKER_URL)
          @agent.form_with(name: "post") do |form|                    #search form
            category_extractor = proc { |title| title.gsub(/\A\p{Space}*/u, '').gsub(/\A\|-\p{Space}/u, '').gsub(/\p{Space}\Z/u, '') }
            available_tracker_sections = Hash[form.field('f[]').options.map { |opt| [category_extractor[opt.text], opt] }]
            @tracker_sections.each do |section|
              option = available_tracker_sections[section] or next
              debug_message("Section: #{section}")
              option.tick
            end
            form.field('tm').option_with(:text => /сегодня/i).select  #period dropdown
            form.checkbox('sd').check                                 #with seeders
            form.checkbox('dc').uncheck                               #tracker macro category not needed
            form.checkbox('df').check                                 #tracker category
          end.submit
        end
      end
    end
  end
end

