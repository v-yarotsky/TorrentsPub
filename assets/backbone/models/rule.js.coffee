window.TorrentsPub ?= {}

class TorrentsPub.Rule extends Backbone.Model
  defaults:
    category: "Movies"
    trackerSection: 'T.by moview'
    requiredKeywords: 'http://google.com'
    deniedKeywords: 'camrip'


