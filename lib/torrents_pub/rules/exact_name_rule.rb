module TorrentsPub
  module Rules

    class ExactTitleRule
      def initialize(exact_torrent_title)
        @title = exact_torrent_title
      end

      def match?(torrent_attributes)
        torrent_attributes[:title].to_s == @title
      end
    end

  end
end
