window.TorrentsPub ?= {}

class TorrentsPub.NavigationView extends Backbone.View
  template: JST["templates/common/navigation"]

  events:
    'click a': 'navItemClick'

  initialize: ->
    @render()

  navItemClick: (e) =>
    e.preventDefault()
    $link = $(e.target)
    route = $link.attr("href")
    @navigate(route)
    false

  navigate: (route) =>
    $navItems = @$("li")
    $navItems.removeClass("active")
    $navItem = @$("a[href='#{route}']").closest("li")
    $navItem.addClass('active')
    window.eventDispatcher.trigger("navigate", route)

  render: =>
    @$el.html(@template())
    @

