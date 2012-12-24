module TorrentsPub
  module Rules

    class DeniedKeywordsRule
      def initialize(denied_keywords_string)
        @denied_keywords = denied_keywords_string.to_s.split(/[.,;]\s*/)
      end

      def match?(torrent_attributes)
        not @denied_keywords.any? { |w| torrent_attributes[:title].to_s =~ Regexp.new(w, :case_sensitive => false) }
      end
    end

  end
end
