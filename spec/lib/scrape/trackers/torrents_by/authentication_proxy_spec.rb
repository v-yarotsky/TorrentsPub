# encoding: utf-8
require 'spec_helper'
require 'scrape/tracker'
require 'scrape/trackers/torrents_by/authentication_proxy'

module Scrape
  module Trackers
    describe TorrentsByTracker::AuthenticationProxy do
      before(:each) do
        @agent = stub(:FakeAgent).as_null_object
        @subject = anything
        @proxy = TorrentsByTracker::AuthenticationProxy.new(@subject, @agent, "jack", "smith")
      end

      describe "#login" do
        let(:login_form) do
          mock("Login form").tap do |f|
            f.should_receive(:login_username=).with("jack")
            f.should_receive(:login_password=).with("smith")
            f.should_receive(:click_button)
          end
        end

        it "should log user in if credentials valid" do
          @agent.should_receive(:visit_url).with("http://torrents.by/forum/index.php").ordered
          @agent.should_receive(:form_with).with(action: './login.php').ordered.and_yield(login_form).and_return(login_form)
          @agent.should_receive(:form_with).with(action: './login.php').ordered.and_return(nil)
          @proxy.login
        end

        it "should raise error if login failed" do
          @agent.should_receive(:visit_url).with("http://torrents.by/forum/index.php").ordered
          @agent.should_receive(:form_with).with(action: './login.php').ordered.and_yield(login_form).and_return(login_form)
          @agent.should_receive(:form_with).with(action: './login.php').ordered.and_return(login_form)

          expect { @proxy.login }.to raise_error(AuthenticationProxy::LoginError)
        end
      end

      specify "#logout" do
        @agent.should_receive(:visit_url).with("http://torrents.by/forum/login.php?logout=1")

        @proxy.logout
      end
    end
  end
end

