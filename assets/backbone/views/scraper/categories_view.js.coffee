window.TorrentsPub ?= {}

class TorrentsPub.CategoriesView extends Backbone.View
  tagName: 'div'
  id: 'categories'
  className: 'span9'

  render: =>
    @$el.empty()

    for category in @collection.models
      categoryView = new TorrentsPub.CategoryView(model: category)
      @$el.append(categoryView.render().el)
    @

