require 'torrents_pub/rules'

module TorrentsPub

  UnknownRuleTypeError = Class.new(StandardError)

  class TrackerSection
    attr_reader :tracker_name, :tracker_section, :category

    def initialize(category, attributes)
      @category = category
      @attributes = attributes
      @tracker_name, @tracker_section = attributes.values_at("tracker_name", "tracker_section")
      @rules = attributes.fetch("rules") { [] }.map do |rule_attributes|
        create_rule(rule_attributes)
      end
    end

    def to_json(*args)
      @attributes.to_json(*args)
    end

    def match?(torrent_attributes)
      @rules.all? { |r| r.match?(torrent_attributes) }
    end

    private

    def create_rule(rule_attributes)
      rule_type = rule_attributes.fetch("rule")
      rule_argument = rule_attributes["rule_argument"]
      case rule_type
      when "allowed_keywords" then Rules::AllowedKeywordsRule.new(rule_argument)
      when "denied_keywords"  then Rules::DeniedKeywordsRule.new(rule_argument)
      when "exact_name"       then Rules::ExactNameRule.new(rule_argument)
      when "min_seeders"      then Rules::MinSeedersRule.new(rule_argument)
      else
        raise UnknownRuleTypeError.new(rule_attributes)
      end
    end
  end

end
