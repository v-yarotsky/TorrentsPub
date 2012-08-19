window.TorrentsPub ?= {}

class TorrentsPub.EditTrackerView extends Backbone.View
  template: JST["templates/settings/edit_tracker"]

  events:
    'click input[type="submit"]': 'save'

  initialize: ->
    @rulesView = new TorrentsPub.RulesView(collection: @model.get('rules'))

  save: (e) =>
    e.preventDefault()
    data = @$("form").serialize()
    xhr = $.post(@model.url(), data)
    xhr.success =>
      window.eventDispatcher.trigger('notification:success', message: "Tracker settings saved.")
    xhr.error =>
      window.eventDispatcher.trigger('notification:error', message: "Failed to save tracker settings!")

  render: =>
    @$el.html(@template(@model.toJSON()))
    @$("#rules").html(@rulesView.render().el)
    @


