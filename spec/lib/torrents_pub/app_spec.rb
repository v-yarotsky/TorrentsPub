require 'rubygems'
require 'bundler/setup'

$:.unshift File.expand_path('../../lib', __FILE__)

require 'torrents_pub/environment'
TorrentsPub::Environment.setup

require 'torrents_pub/app'

require 'rspec'
require 'rack/test'
require 'rspec/autorun'

=begin
module TorrentsPub
  describe App do
    include Rack::Test::Methods

    def app
      described_class.new
    end

    describe "GET /trackers" do
      it "return trackers json collection" do
        Tracker.should_receive(:all).and_return(stub(:to_json => 'the-json'))
        get '/trackers'
        last_response.should be_ok
        last_response.body.should == "the-json"
      end
    end

    describe "GET /trackers/:id" do
      it "return tracker as JSON if exists" do
        tracker = stub(:Tracker, :to_json => "the-json")
        Tracker.should_receive(:get).with("1").and_return(tracker)
        get '/trackers/1'
        last_response.should be_ok
        last_response.body.should == "the-json"
      end

      it "should return 404 if tracker not found" do
        Tracker.should_receive(:get).with("1").and_return(nil)
        get '/trackers/1'
        last_response.should_not be_ok
        last_response.status.should == 404
      end
    end
  end
end
=end
