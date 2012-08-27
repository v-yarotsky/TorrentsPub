@module 'TorrentsPub.Settings', ->
  class @CategoriesListView extends Backbone.View
    template: JST["templates/settings/categories"]

    initialize: ->
      @collection.bind("reset", @render)
      @render()

    render: =>
      @$el.html(@template())
      for category in @collection.models
        categoryTabHeaderView = new TorrentsPub.Settings.CategoryTabHeaderView(model: category)
        categoryTabContentView = new TorrentsPub.Settings.CategoryTabContentView(model: category)
        @$(".nav-tabs").append(categoryTabHeaderView.render().el)
        @$(".tab-content").append(categoryTabContentView.render().el)
      @

