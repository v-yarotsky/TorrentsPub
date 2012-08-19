window.TorrentsPub ?= {}

class TorrentsPub.ScraperView extends Backbone.View
  initialize: ->
    @colorGenerator = new TorrentsPub.ColorGenerator()
    @categories = new TorrentsPub.Categories()
    @categorize(@options.torrents)
    @categoriesView ?= new TorrentsPub.CategoriesView(collection: @categories)
    @sidebarView ?= new TorrentsPub.SidebarView(collection: @categories)

  categorize: (torrents) ->
    categories = _([])
    for torrent in torrents
      category = categories.find (c) -> c.get('name') == torrent.media_type
      if category
        category.get('torrents').push(@instantiateTorrent(torrent))
      else
        category = @instantiateCategory(torrent)
        categories.push(category)
    @categories.reset(categories.values())

  instantiateCategory: (torrent) ->
    torrents = new TorrentsPub.CategoryTorrents()
    torrents.reset(@instantiateTorrent(torrent))

    new TorrentsPub.Category
      name: torrent.media_type
      colorClass: @nextCategoryColor()
      torrents: torrents

  instantiateTorrent: (torrent)  -> new TorrentsPub.Torrent(torrent)

  nextCategoryColor: => @colorGenerator.nextColor()

  render: =>
    @$el.empty()
    @$el.append(@sidebarView.render().el)
    @$el.append(@categoriesView.render().el)
    @

