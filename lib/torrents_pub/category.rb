module TorrentsPub
  class Category
    include DataMapper::Resource

    property :id, Serial
    property :name, String, required: true
    property :rules, Json, default: []

    class Rule
      attr_reader :tracker_name, :tracker_section, :required_keywords, :denied_keywords, :min_seeders

      def initialize(attributes)
        @attributes = attributes
        @tracker_name, @tracker_section, @required_keywords, @denied_keywords, @min_seeders = 
          attributes.values_at("tracker_name", "tracker_section", "required_keywords", "denied_keywords", "min_seeders")
      end

      def to_json(*args)
        @attributes.to_json(*args)
      end
    end

    def rules
      attribute_get(:rules).map(&Rule.method(:new))
    end
  end
end

