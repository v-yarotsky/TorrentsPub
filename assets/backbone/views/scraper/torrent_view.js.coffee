@module 'TorrentsPub.Scraper', ->
  class @TorrentView extends Backbone.View
    template: JST["templates/scraper/torrent"]
    tagName: 'tr'
    
    render: =>
      @$el.html(@template(@model.toViewJSON()))
      @

