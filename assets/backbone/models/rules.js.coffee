#= require models/rule.js

@module 'TorrentsPub', ->
  class @Rules extends Backbone.Collection
    model: TorrentsPub.Rule

