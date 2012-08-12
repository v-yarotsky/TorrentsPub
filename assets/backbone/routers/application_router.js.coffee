window.TorrentsPub ?= {}

class TorrentsPub.TorrentsRouter extends Backbone.Router
  routes:
    '': 'scraper'
    'scraper': 'scraper'

  initialize: ->
    @elements =
      'container': $("#container")

    @scraperView = new TorrentsPub.ScraperView()

  scraper: =>
    @elements["container"].html(@scraperView.render().el)


