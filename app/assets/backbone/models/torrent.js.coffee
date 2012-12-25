@module 'TorrentsPub', ->
  class @Torrent extends Backbone.Model
    defaults:
      title: "Hello world"
      seeders: 200
      size: "400 MB"
      downloaded: "false"
      category: "Movies"
      tracker: "Rutracker.org"

