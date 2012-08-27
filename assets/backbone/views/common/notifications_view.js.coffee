@module 'TorrentsPub', ->
  class @NotificationsView extends Backbone.View
    initialize: ->
      @collection.bind('add', @renderNotification)
      @render()

    renderNotification: (notification) =>
      notificationView = new TorrentsPub.NotificationView(model: notification)
      @$el.prepend(notificationView.render().el)

    render: =>
      @$el.empty()
      for notification in @collection.models
        @renderNotification(notification)
      @

