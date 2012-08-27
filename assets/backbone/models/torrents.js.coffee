#= depend_on models/torrent.js

@module 'TorrentsPub', ->
  class @Torrents extends Backbone.Collection
    model: TorrentsPub.Torrent
    url: '/api/torrents'

    refresh: (successCallback)=>
      xhr = $.post '/api/refresh_torrents'
      xhr.success =>
        window.eventDispatcher.trigger('notification:success', title: 'There are new torrents')
        successCallback()
      xhr.error (response) =>
        window.eventDispatcher.trigger('notification:error', title: 'Failed to fetch new torrents', message: response.responseText)

