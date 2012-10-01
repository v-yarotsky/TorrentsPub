require 'spec_helper'
require 'slapjack/tracker'

module Slapjack
  describe Tracker do
    class TestTracker < Tracker
    end

    class FakeAgent; end

    let(:scraper) { mock(:Scraper) }
    let(:downloader) { mock(:TorrentDownloader) }

    let(:tracker_class) do
      tracker_class = Class.new(Tracker)
      tracker_class.agent_creator = proc { FakeAgent.new }
      tracker_class
    end

    before(:each) do
      @tracker = tracker_class.new
      @tracker.stub(scraper: scraper)
      @tracker.stub(downloader: downloader)
    end

    specify "#refresh_torrents! should tell scraper to fetch new torrents" do
      scraper.should_receive(:fetch_torrents)
      @tracker.refresh_torrents!
    end

    describe "#torrents" do
      it "should refresh and return torrents if empty" do
        @tracker.instance_variable_set(:@torrents, [])
        scraper.should_receive(:fetch_torrents).and_return([])
        @tracker.torrents
      end

      it "should use cached torrents if any" do
        @tracker.instance_variable_set(:@torrents, [1, 2, 3])
        scraper.should_not_receive(:fetch_torrents)
        @tracker.torrents
      end

      it "should return a copy" do
        @tracker.instance_variable_set(:@torrents, [1, 2, 3])
        @tracker.torrents.map!(&:to_s)
        @tracker.torrents.should == [1, 2, 3]
      end
    end

    specify "#download_torrent! should tell torrent downloader to download a torrent by url" do
      downloader.should_receive(:download_torrent!).with("the url")
      @tracker.download_torrent!("the url")
    end
  end
end

