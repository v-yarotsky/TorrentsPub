window.TorrentsPub ?= {}

class TorrentsPub.Rule extends Backbone.Model
  defaults:
    tracker: "Torrents.by"
    trackerSection: 'T.by movies'
    requiredKeywords: 'http://google.com'
    deniedKeywords: 'camrip'


