window.TorrentsPub ?= {}

class TorrentsPub.SidebarView extends Backbone.View
  template: JST["templates/scraper/sidebar"]

  initialize: ->
    @render()
  
  render: =>
    @$el.html(@template())
    $categoriesContainer = @$("#categories-list")
    $categoriesContainer.empty()
    for category in @collection.models
      $categoriesContainer.append(new TorrentsPub.SidebarCategoryView(model: category).render().el)
    @

