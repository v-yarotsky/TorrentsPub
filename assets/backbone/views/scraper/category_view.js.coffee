window.TorrentsPub ?= {}

class TorrentsPub.CategoryView extends Backbone.View
  template: JST["templates/scraper/category"]

  events:
    'click [data-sortfield]': 'sortTorrents'
    'keyup input.filter': 'filterTorrents'
  
  initialize: ->
    @model.bind('change:visible', @toggle)
    @torrents = @model.get('torrents')
    @torrents.bind('reset', @renderTorrents)
    @torrents.bind('filter', @renderTorrents)
    @torrents.bind('sort', @renderHeader)

  toggle: =>
    @$el.toggle(@model.get('visible'))

  render: =>
    @$el.html(@template(@model.toJSON()))
    @renderTorrents(@torrents.models)
    @

  renderTorrents: =>
    $torrentsContainer = @$("tbody")
    $torrentsContainer.empty()
    for torrent in @torrents.models
      $torrentsContainer.append(new TorrentsPub.TorrentView(model: torrent).render().el)
    @

  renderHeader: =>
    @$("th[data-sortfield]").removeClass("sort-asc sort-desc")
    @$("th[data-sortfield='#{@torrents.sortAttr}']").addClass(if @torrents.sortAsc is true then "sort-asc" else "sort-desc")

  sortTorrents: (e) =>
    sortField = $(e.target).data("sortfield")
    @torrents.sortByField(sortField)

  filterTorrents: (e) =>
    term = @$(e.target).val()
    @torrents.filterByTitle(term)
