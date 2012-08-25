window.TorrentsPub ?= {}
window.TorrentsPub.Scraper ?= {}

class TorrentsPub.Scraper.ScraperView extends Backbone.View
  initialize: ->
    @torrents   = window.applicationData.torrents
    @categories = window.applicationData.categories
    @categoriesView ?= new TorrentsPub.Scraper.CategoriesView(collection: @categories)
    @sidebarView ?= new TorrentsPub.Scraper.SidebarView(collection: @categories)
    @sidebarView.on('refreshTorrents', @refreshTorrents)

    @categories.on('reset', @render) # DO IT THE RIGHT WAY!! WTF!!
  
    window.eventDispatcher.on('refreshTorrents', @refreshTorrents)

  refreshTorrents: =>
    @torrents.refresh =>
      @torrents.fetch()

  render: =>
    @$el.empty()
    @$el.append(@sidebarView.render().el)
    @$el.append(@categoriesView.render().el)
    @

