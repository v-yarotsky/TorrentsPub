window.TorrentsPub ?= {}

class TorrentsPub.ApplicationRouter extends Backbone.Router
  routes:
    'scraper': 'scraper'
    'settings': 'settings'
    'settings/:trackerId': 'editTracker'
    'downloads': 'downloads'

  initialize: ->
    @elements =
      'container': $("#container")
      'notifications': $("#notifications")
      'navigation': $("#navigation")

    @scraperView = new TorrentsPub.ScraperView(torrents: window.torrents)
    @settingsView = new TorrentsPub.SettingsView()
    @notifications = new TorrentsPub.Notifications()
    @notificationsView = new TorrentsPub.NotificationsView(collection: @notifications, el: @elements["notifications"])
    window.notifications = @notifications

    @downloadsView = new TorrentsPub.DownloadsView()
    @navigationView = new TorrentsPub.NavigationView(el: @elements["navigation"])
    @navigationView.on('navigate', @navigateTo)
    @navigationView.navigate('scraper')

  navigateTo: (route) =>
    @navigate(route, trigger: true)

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

  downloads: =>
    @elements["container"].html(@downloadsView.render().el)

