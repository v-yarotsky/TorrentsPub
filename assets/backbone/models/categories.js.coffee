#= depend_on models/category.js

window.TorrentsPub ?= {}

class TorrentsPub.Categories extends Backbone.Collection
  model: TorrentsPub.Category
  
  constructor: ->
    @torrents = Array.prototype.shift.call(arguments)
    @torrents.on('reset', @resetFromTorrents)
    @colorGenerator = new TorrentsPub.ColorGenerator()
    Backbone.Collection.apply(@, arguments)

  resetFromTorrents: =>
    @colorGenerator.reset()
    categories = _([])
    for torrent in @torrents.models
      category = categories.find (c) -> c.get('name') == torrent.get('category')
      if category
        category.get('torrents').push(torrent)
      else
        category = @instantiateCategory(torrent)
        categories.push(category)
    @reset(categories.values())

  instantiateCategory: (torrent) ->
    torrents = new TorrentsPub.CategoryTorrents()
    torrents.reset([torrent])

    new TorrentsPub.Category
      name: torrent.get('category')
      colorClass: @nextCategoryColor()
      torrents: torrents

  nextCategoryColor: -> @colorGenerator.nextColor()
