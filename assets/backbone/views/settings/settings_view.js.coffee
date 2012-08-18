window.TorrentsPub ?= {}

class TorrentsPub.SettingsView extends Backbone.View
  template: JST["templates/settings/settings"]

  initialize: ->
    @trackers = new TorrentsPub.Trackers()
    @trackers.fetch()

  render: =>
    @$el.html(@template())
    @trackersView ?= new TorrentsPub.TrackersView(collection: @trackers, el: @$("#trackers"))
    @

