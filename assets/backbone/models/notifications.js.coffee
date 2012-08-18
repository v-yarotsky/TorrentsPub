#= depend_on models/notification.js

window.TorrentsPub ?= {}

class TorrentsPub.Notifications extends Backbone.Collection
  model: TorrentsPub.Notification
