window.TorrentsPub ?= {}
window.TorrentsPub.Settings ?= {}

class TorrentsPub.Settings.CategoryTabHeaderView extends Backbone.View
  template: JST["templates/settings/category_tab_header"]
  tagName: 'li'

  render: =>
    @$el.html(@template(@model.toViewJSON()))
    @



