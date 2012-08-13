window.TorrentsPub ?= {}

class TorrentsPub.TrackersView extends Backbone.View
  template: JST["templates/settings/trackers"]

  initialize: ->
    @render()

  render: =>
    @$el.html(@template())
    $trackersContainer = @$("tbody")
    for tracker in @collection.models
      trackerView = new TorrentsPub.TrackerView(model: tracker)
      $trackersContainer.append(trackerView.render().el)
    @

