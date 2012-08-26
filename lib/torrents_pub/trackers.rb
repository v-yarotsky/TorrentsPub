require 'forwardable'
require 'torrents_pub/category'
require 'torrents_pub/tracker'

module TorrentsPub
  class Trackers
    include Enumerable
    extend Forwardable
    def_delegators :@trackers, :each

    class TrackerSection < Struct.new(:name, :category)
    end

    def initialize(config)
      @trackers = []
      tracker_sections_by_tracker = Category.all.each_with_object({}) do |c, result|
        c.rules.each { |r| (result[r.tracker_name] ||= []).push TrackerSection.new(r.tracker_section, c.name) }
      end
      config.each do |name, options|
        tracker_sections = tracker_sections_by_tracker[name].to_a
        tracker_options = Hash[options.map { |k, v| [k.to_sym, v]}]
        tracker = Tracker.new(tracker_options.merge(:name => name, :tracker_sections => tracker_sections))
        @trackers.push tracker
      end
    end

    def names
      @trackers.map(&:name)
    end
    
    def trackers
      @trackers
    end
  end
end

