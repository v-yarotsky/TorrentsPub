module TorrentsPub
  ROOT = File.expand_path('../', File.dirname(__FILE__))
end

$:.unshift File.join(TorrentsPub::ROOT, 'lib')
require 'torrents_pub/app'
