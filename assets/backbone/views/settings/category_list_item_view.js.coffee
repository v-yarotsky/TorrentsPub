window.TorrentsPub ?= {}

class TorrentsPub.CategoryListItemView extends Backbone.View
  template: JST["templates/settings/category_list_item"]

  render: =>
    @$el.html(@template(@model.toJSON()))
    @


