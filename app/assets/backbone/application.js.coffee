#= require util
#= require backbone_extensions
#= require_tree .
#= require_self

@module 'TorrentsPub', ->
  class @ApplicationData
    constructor: ->
      @torrents = new TorrentsPub.Torrents()
      @categories = new TorrentsPub.Categories(@torrents, window.categories)
      @trackers = []

      @loadInitialData()

    loadInitialData: ->
      @torrents.reset(window.torrents)
      @trackers = window.trackers

$ ->
  window.eventDispatcher = _.clone(Backbone.Events)
  window.applicationData = new TorrentsPub.ApplicationData()
  window.notifications = new TorrentsPub.Notifications()
  window.router = new TorrentsPub.ApplicationRouter()
  Backbone.history.start()

