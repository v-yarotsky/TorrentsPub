#= require_tree .
#= require_self

$ ->
  window.torrentsRouter = new TorrentsPub.TorrentsRouter()
  Backbone.history.start()
