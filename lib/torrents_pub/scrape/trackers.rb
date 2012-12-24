module TorrentsPub
  module Scrape
    module Trackers
    end
  end
end

Dir.glob(File.dirname(__FILE__) + '/trackers/*_tracker.rb') do |tracker|
  require tracker
end

