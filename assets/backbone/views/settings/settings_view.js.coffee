@module 'TorrentsPub.Settings', ->
  class @SettingsView extends Backbone.View
    initialize: ->
      @categories = window.applicationData.categories

    render: =>
      @$el.empty()
      @categoriesListView ?= new TorrentsPub.Settings.CategoriesListView(collection: @categories)
      @$el.html(@categoriesListView.render().el)
      @

