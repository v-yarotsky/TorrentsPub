@module 'TorrentsPub.Settings', ->
  class @RulesView extends Backbone.View
    template: JST["templates/settings/rules"]

    className: 'well form-inline'
    tagName: 'div'

    events:
      'click .btn.add': 'addRule'


    initialize: ->
      @collection.bind("reset", @render)
      @collection.bind("add", @renderRule)
      @render()

    addRule: (e) =>
      e.preventDefault()
      @collection.push(new TorrentsPub.Rule())
      false

    renderRule: (rule) =>
      ruleView = new TorrentsPub.Settings.RuleView(model: rule)
      @$el.append(ruleView.render().el)

    render: =>
      @$el.html(@template())
      @renderRule(rule) for rule in @collection.models
      @

