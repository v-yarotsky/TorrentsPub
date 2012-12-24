module TorrentsPub
  module Rules

    class AllowedKeywordsRule
      def initialize(allowed_keywords_string)
        @allowed_keywords = allowed_keywords_string.to_s.split(/[.,;]\s*/)
      end

      def match?(torrent_attributes)
        @allowed_keywords.any? { |w| torrent_attributes[:title].to_s =~ Regexp.new(w, :case_sensitive => false) }
      end
    end

  end
end
