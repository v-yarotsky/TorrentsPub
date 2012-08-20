#= depend_on models/rules.js

window.TorrentsPub ?= {}

class TorrentsPub.Tracker extends Backbone.Model
  urlRoot: '/api/trackers'
  defaults:
    rules: []

  initialize: ->
    @on("change", @initRulesCollection)

  initRulesCollection: =>
    unless @get('rules') instanceof Backbone.Model
      rules = @get('rules')
      rulesCollection = new TorrentsPub.Rules(rules)
      @set({ rules: rulesCollection }, { silent: true })


