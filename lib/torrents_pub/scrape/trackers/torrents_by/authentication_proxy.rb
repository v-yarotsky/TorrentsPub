# encoding: utf-8
require 'torrents_pub/scrape/trackers/xbbt_authentication_proxy'

module TorrentsPub
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
end

