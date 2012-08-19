module TorrentsPub
  class Tracker
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :login_url, String
    property :login, String
    property :password, String
    property :rules, Json, default: []
  end
end


