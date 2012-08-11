window.TorrentsPub ?= {}

class TorrentsPub.CategoriesView extends Backbone.View
  initialize: ->
    @categories = ['foo', 'bar']

  render: =>
    @$el.empty()
    for category in @categories
      categoryView = new TorrentsPub.CategoryView({ model: category })
      @$el.append(categoryView.render().el)
    @

