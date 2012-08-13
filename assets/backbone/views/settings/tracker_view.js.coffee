window.TorrentsPub ?= {}

class TorrentsPub.TrackerView extends Backbone.View
  template: JST["templates/settings/tracker"]
  tagName: 'tr'
  
  render: =>
    @$el.html(@template(@model.toJSON()))
    @

