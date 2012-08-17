module TorrentsPub
  class Torrent
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :size, Float
    property :seeders, Integer
    property :link, String
    property :tracker_link, String
    property :tracker, String
    property :category, String
    property :downloaded, Boolean, :default => false
  end
end

