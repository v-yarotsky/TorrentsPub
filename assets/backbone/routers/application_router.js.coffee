window.TorrentsPub ?= {}

class TorrentsPub.ApplicationRouter extends Backbone.Router
  routes:
    '': 'scraper'
    'scraper': 'scraper'

  initialize: ->
    @elements =
      'container': $("#container")

    @scraperView = new TorrentsPub.ScraperView(torrents: window.torrents)

  scraper: =>
    @elements["container"].html(@scraperView.render().el)


