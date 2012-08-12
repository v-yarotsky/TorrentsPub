window.TorrentsPub ?= {}

class TorrentsPub.CategoriesView extends Backbone.View
  initialize: ->
    @render()

  render: =>
    @$el.empty()
    for category in @collection.models
      categoryView = new TorrentsPub.CategoryView(model: category)
      @$el.append(categoryView.render().el)
    @

