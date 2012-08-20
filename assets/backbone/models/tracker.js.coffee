#= depend_on models/rules.js

window.TorrentsPub ?= {}

class TorrentsPub.Tracker extends Backbone.Model
  urlRoot: '/api/trackers'
  defaults:
    rules: new TorrentsPub.Rules()

  initialize: ->
    @on("change", @initRulesCollection)

  parse: (data) ->
    _.extend(data, rules: new TorrentsPub.Rules(data["rules"]))
    
  # initRulesCollection: =>
  #   unless @get('rules') instanceof Backbone.Model
  #     rules = @get('rules')
  #     rulesCollection = new TorrentsPub.Rules(rules)
  #     @set({ rules: rulesCollection }, { silent: true })

  # toJSON: =>
  #   result = Backbone.Model.prototype.toJSON.apply(@, arguments)
  #   result["rules"] = @get('rules').toJSON()
  #   result

