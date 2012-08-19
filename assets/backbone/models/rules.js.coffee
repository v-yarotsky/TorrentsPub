#= depend_on models/rule.js

window.TorrentsPub ?= {}

class TorrentsPub.Rules extends Backbone.Collection
  model: TorrentsPub.Rule


