window.TorrentsPub ?= {}

class TorrentsPub.TrackerListItemView extends Backbone.View
  template: JST["templates/settings/tracker_list_item"]
  events:
    'click .btn.edit': 'editTracker'

  editTracker: (e) =>
    e.preventDefault()
    window.eventDispatcher.trigger('navigate', "/trackers/#{@model.get('id')}")
    false

  render: =>
    @$el.html(@template(@model.toJSON()))
    @

