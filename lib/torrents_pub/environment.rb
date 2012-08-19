require 'data_mapper'

module TorrentsPub
  class Environment
    DB_CONFIG_PATH = File.expand_path('../../../config/database.yml', __FILE__).freeze

    class << self

      def environment_name
        ENV["TORRENTS_PUB_ENV"] || "development"
      end

      def setup
        setup_db
      end

      private

      def setup_db
        full_config = YAML.load(File.read(DB_CONFIG_PATH))
        
        connections = full_config[environment_name]
        
        connections.each do |(name, config)|
          DataMapper.setup(name.to_sym, config)
        end

        DataMapper.auto_upgrade!
      end

    end
  end
end

