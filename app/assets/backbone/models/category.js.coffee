#= require models/tracker_sections.js

@module 'TorrentsPub', ->
  class @Category extends Backbone.Model
    urlRoot: '/api/categories'
    attrWhitelist: ['name', 'tracker_sections']

    defaults:
      visible: true

    initialize: ->
      @set(tracker_sections: new TorrentsPub.TrackerSections(@get("tracker_sections")))
      @set(torrents: new TorrentsPub.CategoryTorrents())

    parse: (data) ->
      _.extend(data, tracker_sections: new TorrentsPub.TrackerSections(data["tracker_sections"]))

    toggle: ->
      @set(visible: !@get('visible'))

    activeColorClass: ->
      if @get('visible') == true
        @get('colorClass')
      else
        'gray'

    toViewJSON: ->
      _.extend(super, colorClass: @activeColorClass())

