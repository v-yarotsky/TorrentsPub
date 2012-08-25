window.TorrentsPub ?= {}
window.TorrentsPub.Scraper ?= {}

class TorrentsPub.Scraper.CategoriesView extends Backbone.View
  tagName: 'div'
  id: 'categories'
  className: 'span9'

  render: =>
    @$el.empty()

    for category in @collection.models
      categoryView = new TorrentsPub.Scraper.CategoryView(model: category)
      @$el.append(categoryView.render().el)
    @

