window.TorrentsPub ?= {}

class TorrentsPub.TrackersView extends Backbone.View
  initialize: ->
    @collection.bind("reset", @render)
    @render()

  render: =>
    @$el.empty()
    for tracker in @collection.models
      trackerView = new TorrentsPub.TrackerListItemView(model: tracker)
      @$el.append(trackerView.render().el)
    @

