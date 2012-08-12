window.TorrentsPub ?= {}

class TorrentsPub.CategoryView extends Backbone.View
  template: JST["templates/scraper/category"]
  
  initialize: ->
    @model.bind('change:visible', @toggle)

  toggle: =>
    @$el.toggle(@model.get('visible'))

  render: =>
    @$el.html(@template(@model.toJSON()))
    $torrentsContainer = @$("tbody")
    $torrentsContainer.empty()
    for torrent in @model.get('torrents')
      $torrentsContainer.append(new TorrentsPub.TorrentView(model: torrent).render().el)
    @
