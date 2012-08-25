#= require_tree .
#= require_self

window.TorrentsPub ?= {}

class TorrentsPub.ApplicationData
  constructor: ->
    @torrents = new TorrentsPub.Torrents()
    @categories = new TorrentsPub.Categories(@torrents)

    @loadInitialData()

  loadInitialData: ->
    @torrents.reset(window.torrents)

$ ->
  window.eventDispatcher = _.clone(Backbone.Events)
  window.applicationData = new TorrentsPub.ApplicationData()
  window.notifications = new TorrentsPub.Notifications()
  window.router = new TorrentsPub.ApplicationRouter()
  Backbone.history.start()

