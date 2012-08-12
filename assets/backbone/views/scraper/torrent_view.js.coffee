window.TorrentsPub ?= {}

class TorrentsPub.TorrentView extends Backbone.View
  template: JST["templates/scraper/torrent"]
  tagName: 'tr'
  
  render: =>
    @$el.html(@template(@model.toJSON()))
    @

