window.TorrentsPub ?= {}

class TorrentsPub.SidebarView extends Backbone.View
  template: JST["templates/torrents/sidebar"]
  
  render: =>
    @$el.html(@template())
    @

