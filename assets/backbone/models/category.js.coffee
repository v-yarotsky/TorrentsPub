#= require models/rules.js

@module 'TorrentsPub', ->
  class @Category extends Backbone.Model
    urlRoot: '/api/categories'
    attrWhitelist: ['name', 'rules']

    defaults:
      visible: true

    initialize: ->
      @set(rules: new TorrentsPub.Rules(@get("rules")))
      @set(torrents: new TorrentsPub.CategoryTorrents())

    parse: (data) ->
      _.extend(data, rules: new TorrentsPub.Rules(data["rules"]))

    toggle: ->
      @set(visible: !@get('visible'))

    activeColorClass: ->
      if @get('visible') == true
        @get('colorClass')
      else
        'gray'

    toViewJSON: ->
      _.extend(super, colorClass: @activeColorClass())

