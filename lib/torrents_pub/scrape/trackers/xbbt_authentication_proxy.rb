require 'torrents_pub/scrape/authentication_proxy'

module TorrentsPub
  module Scrape
    module Trackers
      class XbbtAuthenticationProxy < AuthenticationProxy
        def initialize(subject, agent, login, password)
          super(subject)
          @agent, @login, @password = agent, login, password
        end

        def login
          @agent.visit_url(login_url)
          @agent.form_with(login_form_criteria) do |form|
            form.login_username = @login
            form.login_password = @password
          end.click_button
          raise LoginError unless login_successful?
        end

        def logout
          @agent.visit_url(logout_url)
        end

        private

        def login_successful?
          @agent.form_with(login_form_criteria).nil?
        end

        abstract_method :login_url
        abstract_method :logout_url
        abstract_method :login_form_criteria
      end
    end
  end
end

