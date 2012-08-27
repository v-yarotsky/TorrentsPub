@module 'TorrentsPub', ->
  class @NotificationView extends Backbone.View
    template: JST["templates/common/notification"]
    tagName: 'div'

    events:
      'click .close': 'close'
    
    render: =>
      @$el.hide()
      @$el.html(@template(@model.toViewJSON()))
      @$el.addClass("alert alert-#{@model.get('type')}")
      @$el.fadeIn(300)
      @

    close: (e) =>
      e.preventDefault()
      @model.destroy()
      @remove()
      false

