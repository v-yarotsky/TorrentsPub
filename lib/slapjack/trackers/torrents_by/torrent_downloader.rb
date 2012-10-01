require 'slapjack/torrent_downloader'

module Slapjack
  module Trackers
    class TorrentsByTracker < Slapjack::Tracker
      class TorrentDownloader < Slapjack::TorrentDownloader
      end
    end
  end
end

