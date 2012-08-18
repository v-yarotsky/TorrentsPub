window.TorrentsPub ?= {}

class TorrentsPub.EditTrackerView extends Backbone.View
  template: JST["templates/settings/edit_tracker"]

  render: =>
    @$el.html(@template(@model.toJSON()))
    @


