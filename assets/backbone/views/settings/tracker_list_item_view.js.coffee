window.TorrentsPub ?= {}

class TorrentsPub.TrackerListItemView extends Backbone.View
  template: JST["templates/settings/tracker_list_item"]
  events:
    'click .btn.edit': 'editTracker'

  editTracker: (e) =>
    e.preventDefault()
    window.eventDispatcher.trigger('navigate', @model.url())
    false

  render: =>
    @$el.html(@template(@model.toJSON()))
    @

