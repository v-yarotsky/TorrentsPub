window.TorrentsPub ?= {}

class TorrentsPub.NotificationsView extends Backbone.View
  initialize: ->
    @collection.bind('add', @render)
    @render()

  render: =>
    @$el.empty()
    for notification in @collection.models
      notificationView = new TorrentsPub.NotificationView(model: notification)
      @$el.prepend(notificationView.render().el)
    @


