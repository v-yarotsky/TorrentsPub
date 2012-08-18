#= require_tree .
#= require_self

$ ->
  window.eventDispatcher = _.clone(Backbone.Events)
  window.router = new TorrentsPub.ApplicationRouter()
  Backbone.history.start(pushState: true)

