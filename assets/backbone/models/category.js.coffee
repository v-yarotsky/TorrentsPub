window.TorrentsPub ?= {}

class TorrentsPub.Category extends Backbone.Model
  defaults:
    color: "green"
    visible: true

  initialize: ->
    @activeColor = @get('color')

  toggle: ->
    if @get('visible') == true
      @set(visible: false, color: "gray")
    else
      @set(visible: true, color: @activeColor)

