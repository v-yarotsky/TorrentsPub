window.TorrentsPub ?= {}

class TorrentsPub.ApplicationRouter extends Backbone.Router
  routes:
    '': 'scraper'
    'scraper': 'scraper'
    'settings': 'settings'
    'settings/:trackerId': 'editTracker'

  initialize: ->
    @elements =
      'container': $("#container")

    @scraperView = new TorrentsPub.ScraperView(torrents: window.torrents)
    @settingsView = new TorrentsPub.SettingsView()

  scraper: =>
    @elements["container"].html(@scraperView.render().el)

  settings: =>
    @elements["container"].html(@settingsView.render().el)

  editTracker: (trackerId) =>
    tracker = new TorrentsPub.Tracker(id: trackerId)
    tracker.fetch(wait: true)
    editTrackerView = new TorrentsPub.EditTrackerView(model: tracker)
    @elements["container"].html(editTrackerView.render().el)



