require 'data_mapper'

module TorrentsPub
  class Environment
    def self.setup
      DataMapper.setup(:default, 'sqlite:////Users/vladimiryarotsky/Projects/torrents_pub/qux.db')
      DataMapper.auto_upgrade!
    end
  end
end

