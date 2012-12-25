@module 'TorrentsPub', ->
  class @ApplicationRouter extends Backbone.Router
    routes:
      'scraper': 'scraper'
      'settings': 'settings'
      'downloads': 'downloads'

    initialize: ->
      @elements =
        'container': $("#container")
        'notifications': $("#notifications")
        'navigation': $("#navigation")

      @scraperView = new TorrentsPub.Scraper.ScraperView()
      @settingsView = new TorrentsPub.Settings.SettingsView()
      @notificationsView = new TorrentsPub.NotificationsView(collection: window.notifications, el: @elements["notifications"])

      @downloadsView = new TorrentsPub.Downloads.DownloadsView()
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

    downloads: =>
      @elements["container"].html(@downloadsView.render().el)

