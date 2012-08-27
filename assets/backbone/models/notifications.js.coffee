#= depend_on models/notification.js

@module 'TorrentsPub', ->
  class @Notifications extends Backbone.Collection
    model: TorrentsPub.Notification
