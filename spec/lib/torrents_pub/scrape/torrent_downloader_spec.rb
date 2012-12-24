require 'uri'
require 'spec_helper'
require 'torrents_pub/scrape/torrent_downloader'

module TorrentsPub::Scrape
  describe TorrentDownloader do
    class FakeAgent; end

    before(:each) do
      @agent                = FakeAgent.new
      @downloader           = TorrentDownloader.new(@agent)
      @downloader.directory = "bar"
    end

    specify "#download_torrent!" do
      file = mock("Torrent file", filename: "foo").tap { |f| f.should_receive(:save).with("bar/foo") }
      @agent.should_receive(:download).with("foo").and_return(file)
      @downloader.download_torrent!("foo").should == "bar/foo"
    end
  end
end

