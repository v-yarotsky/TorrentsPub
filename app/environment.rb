require 'data_mapper'

module TorrentsPub

  class Environment
    CONFIG_ROOT = File.expand_path('../config', __FILE__).freeze
    DB_CONFIG_PATH = File.join(CONFIG_ROOT, 'database.yml').freeze

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

require 'app/application'

