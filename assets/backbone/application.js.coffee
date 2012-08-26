#= require_tree .
#= require_self

window.TorrentsPub ?= {}

Backbone.Model.prototype.toViewJSON = ->
  _.clone(@attributes)

Backbone.Model.prototype.toJSON = ->
  if @attrWhitelist?
    _.pick(@attributes, @attrWhitelist)
  else
    _.clone(@attributes)

class TorrentsPub.ApplicationData
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

