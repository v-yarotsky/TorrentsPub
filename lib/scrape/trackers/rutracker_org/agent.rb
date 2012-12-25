require 'scrape/agent'

module Scrape
  module Trackers

    class RutrackerOrgTracker < Tracker

      class Agent < Agent
        def visit_url_with_post(url, params = {})
          @agent.post(url, params.merge(form_token: post_form_token))
        end

        private

        def post_form_token
          page.body =~ /params\['form_token'\] = '(?<token>\w+)';/
          $1
        end
      end

    end

  end
end

