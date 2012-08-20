window.TorrentsPub ?= {}

class TorrentsPub.ScraperView extends Backbone.View
  initialize: ->
    @colorGenerator = new TorrentsPub.ColorGenerator()
    @categories = new TorrentsPub.Categories()
    @categorize(@collection)
    @categoriesView ?= new TorrentsPub.CategoriesView(collection: @categories)
    @sidebarView ?= new TorrentsPub.SidebarView(collection: @categories)
    @sidebarView.on('refreshTorrents', @refreshTorrents)

    @collection.on('reset', @categorize)
    @categories.on('reset', @render) # DO IT THE RIGHT WAY!! WTF!!
  
    window.eventDispatcher.on('refreshTorrents', @refreshTorrents)

  refreshTorrents: =>
    @collection.refresh =>
      @collection.fetch()

  categorize: =>
    @colorGenerator.reset()
    categories = _([])
    for torrent in @collection.models
      category = categories.find (c) -> c.get('name') == torrent.get('category')
      if category
        category.get('torrents').push(torrent)
      else
        category = @instantiateCategory(torrent)
        categories.push(category)
    @categories.reset(categories.values())

  instantiateCategory: (torrent) ->
    torrents = new TorrentsPub.CategoryTorrents()
    torrents.reset([torrent])

    new TorrentsPub.Category
      name: torrent.get('category')
      colorClass: @nextCategoryColor()
      torrents: torrents

  nextCategoryColor: => @colorGenerator.nextColor()

  render: =>
    @$el.empty()
    @$el.append(@sidebarView.render().el)
    @$el.append(@categoriesView.render().el)
    @

