window.TorrentsPub ?= {}

class TorrentsPub.RuleView extends Backbone.View
  template: JST["templates/settings/rule"]

  tagName: 'div'
  className: 'rule'

  events:
    'click .btn.remove': 'removeRule'

  removeRule: (e) =>
    e.preventDefault()
    @model.trigger("destroy")
    @remove()

    false

  render: =>
    @$el.html(@template(@model.toJSON()))
    @$("input[name='category']").typeahead(source: ['foo', 'bar'])
    @


