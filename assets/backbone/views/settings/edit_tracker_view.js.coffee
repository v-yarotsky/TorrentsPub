window.TorrentsPub ?= {}

class TorrentsPub.EditTrackerView extends Backbone.View
  template: JST["templates/settings/edit_tracker"]

  initialize: ->
    @rulesView = new TorrentsPub.RulesView(collection: @model.get('rules'))

  render: =>
    @$el.html(@template(@model.toJSON()))
    @$("#rules").html(@rulesView.render().el)
    @


