require 'app/models/tracker_section'

class Category
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :tracker_sections, Json, default: []


  def tracker_sections_by_tracker_name(tracker_name)
    tracker_sections.select { |s| s.tracker_name == tracker_name }
  end

  def tracker_sections
    @tracker_sections ||= attribute_get(:tracker_sections).map do |tracker_section_attributes|
      TrackerSection.new(self.name, tracker_section_attributes)
    end
  end
end

