window.TorrentsPub ?= {}

class TorrentsPub.ScraperView extends Backbone.View
  template: JST["templates/scraper/scraper"]

  initialize: ->
    @colors = ['green', 'blue', 'magenta']
    @categories = new TorrentsPub.Categories()
    @categorize(@options.torrents)

  categorize: (torrents) ->
    categories = _([])
    for torrent in torrents
      category = categories.find (c) ->
        c.get('name') == torrent.category
      if category
        category.get('torrents').push(@instantiateTorrent(torrent))
      else
        category = @instantiateCategory(torrent)
        categories.push(category)
    @categories.reset(categories.values())

  instantiateTorrent: (torrent) -> new TorrentsPub.Torrent(torrent)
  instantiateCategory: (torrent) -> new TorrentsPub.Category(name: torrent.category, color: @nextCategoryColor(), torrents: [@instantiateTorrent(torrent)])
  nextCategoryColor: => @colors.shift()

      
  render: =>
    @$el.html(@template())
    @categoriesView ?= new TorrentsPub.CategoriesView(el: @$("#categories"), collection: @categories)
    @sidebarView ?= new TorrentsPub.SidebarView(el: @$("#sidebar"), collection: @categories)
    @

