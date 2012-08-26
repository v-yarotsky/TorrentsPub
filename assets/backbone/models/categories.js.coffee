#= require models/category.js

window.TorrentsPub ?= {}

class TorrentsPub.Categories extends Backbone.Collection
  url: '/api/categories'
  model: TorrentsPub.Category
  
  constructor: ->
    @torrents = Array.prototype.shift.call(arguments)
    Backbone.Collection.apply(@, arguments)
    @torrents.on('reset', @fillFromTorrents)
    @colorGenerator = new TorrentsPub.ColorGenerator()
    @models.forEach(@assignColor)
    @on('add', @assignColor)

  fillFromTorrents: =>
    category.get('torrents').reset([], silent: true) for category in @models

    for torrent in @torrents.models
      category = @find (c) -> c.get('name') == torrent.get('category')
      category.get('torrents').push(torrent)

  assignColor: (model) =>
    console.log("setting color")
    model.set({ colorClass: @colorGenerator.nextColor() }, silent: true)
