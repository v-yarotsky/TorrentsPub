require 'forwardable'
require 'app/models/category'
require 'app/models/tracker'

class Trackers
  include Enumerable
  extend Forwardable
  def_delegators :@trackers, :each

  def initialize(config)
    @trackers = []
    config.each do |name, options|
      tracker_sections = tracker_sections_by_tracker_name(name)
      tracker_attributes = symbolize_keys(options).merge(:name => name, :tracker_sections => tracker_sections)
      tracker = Tracker.new(tracker_attributes)
      @trackers.push tracker
    end
  end

  def names
    @trackers.map(&:name)
  end

  def trackers
    @trackers
  end

  private

  def tracker_sections_by_tracker_name(tracker_name)
    Category.all.each_with_object([]) do |c, r|
      r.concat(c.tracker_sections_by_tracker_name(tracker_name))
    end
  end

  def symbolize_keys(hsh)
    Hash[hsh.map { |k, v| [k.to_sym, v]}]
  end
end

