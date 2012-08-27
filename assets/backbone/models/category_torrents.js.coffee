#= depend_on models/torrent.js

@module 'TorrentsPub', ->
  class @CategoryTorrents extends Backbone.Collection
    model: TorrentsPub.Torrent
    sortAttr: 'title'
    filterAttr: 'title'
    sortAsc: true

    sortByField: (field) =>
      if @sortAttr == field
        @sortAsc = !@sortAsc
      else
        @sortAttr = field
        @sortAsc = true
      @trigger('sort')
      @sort()

    comparator: (t1, t2) =>
      direction = if @sortAsc is true then 1 else -1
      t1Attr = t1.get(@sortAttr)
      t2Attr = t2.get(@sortAttr)
      if t1Attr.toLowerCase?
        return if t1Attr.toLowerCase() >= t2Attr.toLowerCase() then direction else -direction
      if t1Attr >= t2Attr then direction else -direction
    
    filterByTitle: (term) =>
      if term == ""
        if @originalModels?
          @models = @originalModels
          @originalModels = null
      else
        @originalModels ?= @models
        pattern = new RegExp(term, "gi")
        @models = _(@originalModels).filter (model) =>
          pattern.test(model.get(@filterAttr))
      @sort()
      @trigger('filter')

