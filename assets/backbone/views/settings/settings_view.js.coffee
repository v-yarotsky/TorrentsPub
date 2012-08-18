window.TorrentsPub ?= {}

class TorrentsPub.SettingsView extends Backbone.View
  id: 'trackers'
  className: 'span6'

  initialize: ->
    @trackers = new TorrentsPub.Trackers()

  render: =>
    @$el.empty()
    @trackers.fetch
      success: =>
        @trackersView = new TorrentsPub.TrackersView(collection: @trackers)
        @$el.html(@trackersView.render().el)
      error: => window.eventDispatcher.trigger('notification:error', title: 'No trackers found', message: 'There are no defined trackers.')
    @

