window.TorrentsPub ?= {}

class TorrentsPub.ScraperView extends Backbone.View
  template: JST["templates/scraper/scraper"]

  initialize: ->
    category1 = new TorrentsPub.Category(name: 'Foo', color: 'blue', torrents: [new TorrentsPub.Torrent()])
    category2 = new TorrentsPub.Category(name: 'Bar', color: 'green', torrents: [new TorrentsPub.Torrent(), new TorrentsPub.Torrent()])
    @categories = new TorrentsPub.Categories()
    @categories.reset([category1, category2])

  render: =>
    @$el.html(@template())
    @categoriesView ?= new TorrentsPub.CategoriesView(el: @$("#categories"), collection: @categories)
    @sidebarView ?= new TorrentsPub.SidebarView(el: @$("#sidebar"), collection: @categories)
    @

