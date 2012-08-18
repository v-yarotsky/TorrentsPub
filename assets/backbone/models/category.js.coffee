window.TorrentsPub ?= {}

class TorrentsPub.Category extends Backbone.Model
  defaults:
    visible: true

  initialize: ->
    @set(activeColorClass: @get('colorClass'))

  toggle: ->
    if @get('visible') == true
      @set(visible: false, colorClass: "gray")
    else
      @set(visible: true, colorClass: @get('activeColorClass'))

