window.TorrentsPub ?= {}

class TorrentsPub.TrackerView extends Backbone.View
  template: JST["templates/settings/tracker"]
  events:
    'click .btn.edit': 'editTracker'

  editTracker: (e) =>
    e.preventDefault()
    window.eventDispatcher.trigger('navigate', @model.url())
    false

  render: =>
    @$el.html(@template(@model.toJSON()))
    @

