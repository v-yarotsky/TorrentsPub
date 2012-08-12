#= depend_on models/category.js

window.TorrentsPub ?= {}

class TorrentsPub.Categories extends Backbone.Collection
  model: TorrentsPub.Category
