window.TorrentsPub ?= {}

class TorrentsPub.SidebarView extends Backbone.View
  template: JST["templates/scraper/sidebar"]
  tagName: 'div'
  id: 'sidebar'
  className: 'span3'

  render: =>
    @$el.html(@template())
    $categoriesContainer = @$("#categories-list")
    $categoriesContainer.empty()
    for category in @collection.models
      $categoriesContainer.append(new TorrentsPub.SidebarCategoryView(model: category).render().el)
    @

