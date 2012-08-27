@module 'TorrentsPub.Scraper', ->
  class @SidebarView extends Backbone.View
    template: JST["templates/scraper/sidebar"]
    tagName: 'div'
    id: 'sidebar'
    className: 'span3'

    events:
      'click #refresh': 'refreshTorrents'

    refreshTorrents: (e) =>
      e.preventDefault()
      window.eventDispatcher.trigger('refreshTorrents')


    render: =>
      @$el.html(@template())
      $categoriesContainer = @$("#categories-list")
      $categoriesContainer.empty()
      for category in @collection.models
        $categoriesContainer.append(new TorrentsPub.Scraper.SidebarCategoryView(model: category).render().el)
      @

