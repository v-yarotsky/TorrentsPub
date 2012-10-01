require 'torrents_pub/rule'

module TorrentsPub
  class Category
    include DataMapper::Resource

    property :id, Serial
    property :name, String, required: true
    property :rules, Json, default: []

    def rules
      attribute_get(:rules).map(&Rule.method(:new))
    end
  end
end

