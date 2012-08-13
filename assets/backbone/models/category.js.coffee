window.TorrentsPub ?= {}

class TorrentsPub.Category extends Backbone.Model
  defaults:
    visible: true

  initialize: ->
    @activeColorClass = @get('colorClass')

  toggle: ->
    if @get('visible') == true
      @set(visible: false, colorClass: "gray")
    else
      @set(visible: true, colorClass: @activeColorClass)

