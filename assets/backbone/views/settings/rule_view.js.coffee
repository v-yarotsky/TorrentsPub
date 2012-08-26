window.TorrentsPub ?= {}
window.TorrentsPub.Settings ?= {}

class TorrentsPub.Settings.RuleView extends Backbone.View
  template: JST["templates/settings/rule"]

  tagName: 'div'
  className: 'rule'

  events:
    'click .btn.remove': 'removeRule'

  removeRule: (e) =>
    e.preventDefault()
    @model.trigger("destroy")
    @remove()

    false

  render: =>
    @$el.html(@template(@model.toViewJSON()))
    $trackerSelectBox = @$("select[name='rule_tracker_name']")
    for tracker in window.applicationData.trackers
      $trackerSelectBox.append("<option value='#{tracker}'>#{tracker}</option>")
    $trackerSelectBox.find("option[value='#{@model.get('tracker_name')}']").attr("selected", true)
    @


