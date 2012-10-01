# encoding: utf-8
require 'slapjack/trackers/xbbt_authentication_proxy'

module Slapjack
  module Trackers
    class RutrackerOrgTracker < Slapjack::Tracker
      class AuthenticationProxy < Trackers::XbbtAuthenticationProxy
        def logout
          @agent.visit_url_with_post(logout_url, logout: 1)
        end

        private

        def login_url
          "http://rutracker.org/forum/index.php"
        end

        def logout_url
          "http://login.rutracker.org/forum/login.php"
        end

        def login_form_criteria
          { action: "http://login.rutracker.org/forum/login.php" }
        end
      end
    end
  end
end

