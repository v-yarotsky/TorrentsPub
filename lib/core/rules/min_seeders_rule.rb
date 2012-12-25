module Rules

  class MinSeedersRule
    def initialize(min_seeders_count)
      @min_seeders = min_seeders_count
    end

    def match?(torrent_attributes)
      torrent_attributes[:seeders] >= @min_seeders
    end
  end

end
