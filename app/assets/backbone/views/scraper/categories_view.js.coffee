@module 'TorrentsPub.Scraper', ->
  class @CategoriesView extends Backbone.View
    tagName: 'div'
    id: 'categories'
    className: 'span9'

    initialize: ->
      @collection.on('reset', @render)
      @collection.on('torrents', @render)

    render: =>
      @$el.empty()

      for category in @collection.models
        categoryView = new TorrentsPub.Scraper.CategoryView(model: category)
        @$el.append(categoryView.render().el)
      @

