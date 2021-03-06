@module 'TorrentsPub.Scraper', ->
  class @SidebarCategoryView extends Backbone.View
    tagName: 'li'
    template: JST["templates/scraper/sidebar_category"]
    events:
      'click a': 'toggle'
    
    initialize: ->
      @model.bind('change:visible', @render)

    render: =>
      @$el.html(@template(@model.toViewJSON()))
      @

    toggle: (e) =>
      e.preventDefault()
      @model.toggle()

