#= require_tree .
#= require_self

$ ->
  window.torrentsView = new window.TorrentsPub.TorrentsView()
  window.torrentsView.render()
