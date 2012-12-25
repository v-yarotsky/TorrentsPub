# encoding: utf-8
require 'scrape/trackers/xbbt_authentication_proxy'

module Scrape
  module Trackers

    class TorrentsByTracker < Tracker

      class AuthenticationProxy < Trackers::XbbtAuthenticationProxy
        private

        def login_url
          "http://torrents.by/forum/index.php"
        end

        def logout_url
          "http://torrents.by/forum/login.php?logout=1"
        end

        def login_form_criteria
          { action: "./login.php" }
        end
      end

    end

  end
end

