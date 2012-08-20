window.TorrentsPub ?= {}

class TorrentsPub.TrackersView extends Backbone.View
  template: JST["templates/settings/trackers"]

  events:
    'click #addTracker': 'addTracker'

  initialize: ->
    @collection.bind("reset", @render)
    @render()

  addTracker: (e) =>
    e.preventDefault()
    window.eventDispatcher.trigger('navigate', "/trackers/new")

  render: =>
    @$el.html(@template())
    for tracker in @collection.models
      trackerView = new TorrentsPub.TrackerListItemView(model: tracker)
      @$el.prepend(trackerView.render().el)
    @

