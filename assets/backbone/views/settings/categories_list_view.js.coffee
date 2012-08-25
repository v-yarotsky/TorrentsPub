window.TorrentsPub ?= {}
window.TorrentsPub.Settings ?= {}

class TorrentsPub.Settings.CategoriesListView extends Backbone.View
  initialize: ->
    @collection.bind("reset", @render)
    @render()

  render: =>
    @$el.empty()
    for category in @collection.models
      categoryView = new TorrentsPub.Settings.CategoryListItemView(model: category)
      @$el.prepend(categoryView.render().el)
    @


