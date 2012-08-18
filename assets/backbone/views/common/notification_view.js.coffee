window.TorrentsPub ?= {}

class TorrentsPub.NotificationView extends Backbone.View
  template: JST["templates/common/notification"]
  tagName: 'div'

  events:
    'click .close': 'close'
  
  render: =>
    @$el.html(@template(@model.toJSON()))
    @$el.addClass("alert alert-#{@model.get('type')}")
    @

  close: (e) =>
    e.preventDefault()
    @model.destroy()
    @remove()
    false

