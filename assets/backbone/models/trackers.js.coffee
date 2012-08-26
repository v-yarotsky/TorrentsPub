#= depend_on models/tracker.js

window.TorrentsPub ?= {}

class TorrentsPub.Trackers extends Backbone.Collection
  model: TorrentsPub.Tracker

