window.TorrentsPub ?= {}

class TorrentsPub.ApplicationRouter extends Backbone.Router
  routes:
    'scraper': 'scraper'
    'settings': 'settings'
    'trackers/:trackerId': 'editTracker'
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

    @setUpDispatcherEvents()
    @navigationView.navigate('scraper')

  setUpDispatcherEvents: ->
    window.eventDispatcher.on('navigate', @navigateTo)

    window.eventDispatcher.on 'notification:error', (params) =>
      window.notifications.push(_.extend(params, type: 'error'))

    window.eventDispatcher.on 'notification:info', (params) =>
      window.notifications.push(_.extend(params, type: 'info'))

    window.eventDispatcher.on 'notification:success', (params) =>
      window.notifications.push(_.extend(params, type: 'success'))

  navigateTo: (route) =>
    console.log "Navigating to: #{route}"
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
        window.eventDispatcher.trigger('notification:error', message: "Could not find tracker with id #{trackerId}")

  downloads: =>
    @elements["container"].html(@downloadsView.render().el)

