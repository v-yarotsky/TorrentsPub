require 'uri'

module Scrape

  class TorrentDownloader
    attr_accessor :directory

    def initialize(agent, directory = File.expand_path('../../../', __FILE__))
      @agent     = agent
      @directory = directory
    end

    def download_torrent!(url)
      torrent_file = @agent.download(url)
      filename = "#{directory}/#{torrent_file.filename}"
      torrent_file.save(filename)
      debug_message("Torrent downloaded to: #{filename}")
      filename
    end
  end

end

