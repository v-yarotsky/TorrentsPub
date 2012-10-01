require 'slapjack/agent'

module Slapjack
  module Trackers
    class RutrackerOrgTracker < Slapjack::Tracker
      class Agent < Slapjack::Agent
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

