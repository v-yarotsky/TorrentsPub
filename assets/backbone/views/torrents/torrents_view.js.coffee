window.TorrentsPub ?= {}

class TorrentsPub.TorrentsView extends Backbone.View
  template: JST["templates/torrents/torrents"]
  el: "#container"
  
  initialize: ->
    @categoriesView = new TorrentsPub.CategoriesView()
    @sidebarView  = new TorrentsPub.SidebarView()

  render: =>
    @$el.html(@template())
    $("#categories").html(@categoriesView.render().el)
    $("#sidebar").html(@sidebarView.render().el)
    @

