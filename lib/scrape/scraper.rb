require 'uri'

module Scrape

  class Scraper

    class << self
      attr_accessor :human_name
      attr_accessor :site_url
      attr_accessor :agent_creator

      def site_url=(url)
        @site_url = URI === url ? url : URI.parse(url)
      end
    end

  end

end

