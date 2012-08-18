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
      'notifications': $("#notifications")

    @scraperView = new TorrentsPub.ScraperView(torrents: window.torrents)
    @settingsView = new TorrentsPub.SettingsView()
    @notifications = new TorrentsPub.Notifications()
    @notificationsView = new TorrentsPub.NotificationsView(collection: @notifications, el: @elements["notifications"])
    window.notifications = @notifications

  scraper: =>
    @elements["container"].html(@scraperView.render().el)

  settings: =>
    @elements["container"].html(@settingsView.render().el)

  editTracker: (trackerId) =>
    tracker = new TorrentsPub.Tracker(id: trackerId)
    tracker.fetch
      success: =>
        editTrackerView = new TorrentsPub.EditTrackerView(model: tracker)
        @elements["container"].html(editTrackerView.render().el)
      error: =>
        @navigate('settings', trigger: true)
        @notifications.push(type: 'error', message: "Could not find tracker with id #{trackerId}")

