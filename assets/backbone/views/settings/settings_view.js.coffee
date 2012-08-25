window.TorrentsPub ?= {}
window.TorrentsPub.Settings ?= {}

class TorrentsPub.Settings.SettingsView extends Backbone.View
  initialize: ->
    @categories = window.applicationData.categories
    # @trackers = new TorrentsPub.Trackers()

  render: =>
    @$el.empty()
    # @trackers.fetch
    #   success: =>
    #     @trackersView = new TorrentsPub.TrackersView(collection: @trackers)
    #     @$el.html(@trackersView.render().el)
    #   error: => window.eventDispatcher.trigger('notification:error', title: 'No trackers found', message: 'There are no defined trackers.')
    @categoriesListView ?= new TorrentsPub.Settings.CategoriesListView(collection: @categories)
    @$el.html(@categoriesListView.render().el)
    @

