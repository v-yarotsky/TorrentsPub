window.TorrentsPub ?= {}

class TorrentsPub.CategoryView extends Backbone.View
  template: JST["templates/torrents/category"]
  
  render: =>
    @$el.html(@template())
    @
