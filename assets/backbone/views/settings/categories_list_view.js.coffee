window.TorrentsPub ?= {}

class TorrentsPub.CategoriesListView extends Backbone.View
  initialize: ->
    @collection.bind("reset", @render)
    @render()

  render: =>
    @$el.empty()
    for category in @collection.models
      categoryView = new TorrentsPub.CategoryListItemView(model: category)
      @$el.prepend(categoryView.render().el)
    @


