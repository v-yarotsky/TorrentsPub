class Rule
  attr_reader :tracker_name, :tracker_section, :required_keywords, :denied_keywords, :min_seeders

  def initialize(attributes)
    @attributes = attributes
    @tracker_name, @tracker_section,  @min_seeders =
      attributes.values_at("tracker_name", "tracker_section", "min_seeders")
    @required_keywords, @denied_keywords = attributes.values_at("required_keywords", "denied_keywords").map do |keywords|
      keywords.to_s.split
    end
  end

  def matches?(torrent_attributes)
    check_required_keywords(torrent_attributes) && check_denied_keywords(torrent_attributes)
  end

  def to_json(*args)
    @attributes.to_json(*args)
  end

  private

  def check_required_keywords(torrent_attributes)
    true if @required_keywords.empty?
    @required_keywords.any? { |w| torrent_attributes[:title] =~ Regexp.new(w, :case_sensitive => false) }
  end

  def check_denied_keywords(torrent_attributes)
    true if @denied_keywords.empty?
    @denied_keywords.all? { |w| not torrent_attributes[:title] =~ Regexp.new(w, :case_sensitive => false) }
  end
end
