#= require_tree .
#= require_self

$ ->
  window.router = new TorrentsPub.ApplicationRouter()
  Backbone.history.start()

