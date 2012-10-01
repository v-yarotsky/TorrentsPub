@module 'TorrentsPub', ->
  class @Rule extends Backbone.Model
    defaults:
      tracker: "Torrents.by"
      trackerSection: 'T.by movies'
      requiredKeywords: 'http://google.com'
      deniedKeywords: 'camrip'

    toViewJSON: ->
      _.extend(super, available_trackers: window.applicationData.trackers)
