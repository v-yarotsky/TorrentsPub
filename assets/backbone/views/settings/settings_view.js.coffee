window.TorrentsPub ?= {}

class TorrentsPub.SettingsView extends Backbone.View
  template: JST["templates/settings/settings"]

  initialize: ->
    @trackers = new TorrentsPub.Trackers([{ name: 'Foo' }, { name: 'Bar' }])

  render: =>
    @$el.html(@template())
    @trackersView ?= new TorrentsPub.TrackersView(collection: @trackers, el: @$("#trackers"))
    @

