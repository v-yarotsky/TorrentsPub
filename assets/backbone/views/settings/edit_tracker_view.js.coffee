window.TorrentsPub ?= {}

class TorrentsPub.EditTrackerView extends Backbone.View
  template: JST["templates/settings/edit_tracker"]

  initialize: ->

  render: =>
    @$el.html(@template(@model.toJSON()))
    @


