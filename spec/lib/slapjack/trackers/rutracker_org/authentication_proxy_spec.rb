require 'spec_helper'
require 'slapjack/trackers/rutracker_org/authentication_proxy'
=begin
  module Slapjack
    module Trackers
      describe RutrackerOrgTracker::AuthenticationProxy do
        class FakeAgent; end

        before(:each) do
          @agent = FakeAgent.new
          @subject = anything
          @proxy = RutrackerOrgTracker::AuthenticationProxy.new(@subject, @agent, "jack", "smith")
        end

        specify "#login" do
          @agent.should_receive(:visit_url).with("http://rutracker.org/forum/index.php").ordered

          login_form = mock("Login form").tap do |f|
            f.should_receive(:login_username=).with("jack")
            f.should_receive(:login_password=).with("smith")
            f.should_receive(:click_button)
          end

          @agent.should_receive(:form_with).with(action: 'http://login.rutracker.org/forum/login.php').ordered.and_yield(login_form).and_return(login_form)

          @proxy.login
        end

        specify "#logout" do
          @agent.should_receive(:visit_url).with("http://torrents.by/forum/login.php?logout=1")

          @proxy.logout
        end
      end
    end
  end
=end

