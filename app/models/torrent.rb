class Torrent
  include DataMapper::Resource

  property :id, Serial
  property :title, String, required: true, length: 1..500
  property :size, Float
  property :seeders, Integer
  property :link, String, required: true, unique_index: true
  property :tracker_link, String
  property :tracker, String, required: true
  property :tracker_section, String, required: true
  property :category, String, required: true
  property :downloaded, Boolean, default: false
end

