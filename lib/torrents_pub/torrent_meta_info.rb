module TorrentsPub
  class TorrentMetaInfo
    def initialize(attributes)
      @attributes = attributes
    end

    def files
      info_hash = @attributes.fetch("info")
      info_hash.key?("files") ? info_hash.fetch("files") : [info_hash]
    end

    def total_length
      files.map { |f| f.fetch("length") }.inject(0, :+)
    end

    def creation_date
      Time.at(@attributes.fetch("creation date"))
    end
  end
end

