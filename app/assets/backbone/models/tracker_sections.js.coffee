#= require models/tracker_section.js

@module 'TorrentsPub', ->
  class @TrackerSections extends Backbone.Collection
    model: TorrentsPub.TrackerSection

