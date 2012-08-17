window.TorrentsPub ?= {}

class TorrentsPub.CategoryView extends Backbone.View
  template: JST["templates/scraper/category"]

  events:
    'click [data-sortfield]': 'sortTorrents'
  
  initialize: ->
    @model.bind('change:visible', @toggle)
    @torrents = @model.get('torrents')
    @torrents.bind('reset', @render)

  toggle: =>
    @$el.toggle(@model.get('visible'))

  render: =>
    @$el.html(@template(@model.toJSON()))
    $torrentsContainer = @$("tbody")
    $torrentsContainer.empty()
    for torrent in @torrents.models
      $torrentsContainer.append(new TorrentsPub.TorrentView(model: torrent).render().el)
    @$("th[data-sortfield='#{@torrents.sortAttr}']").addClass(if @torrents.sortAsc is true then "sort-asc" else "sort-desc")
    @

  sortTorrents: (e) =>
    sortField = $(e.target).data("sortfield")
    @torrents.sortBy(sortField)
