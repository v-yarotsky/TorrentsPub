#= depend_on models/tracker.js

@module 'TorrentsPub', ->
  class @Trackers extends Backbone.Collection
    model: TorrentsPub.Tracker

