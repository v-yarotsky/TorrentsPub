window.TorrentsPub ?= {}

class TorrentsPub.DownloadsView extends Backbone.View
  template: JST["templates/downloads/transmission"]

  render: =>
    settings =
      transmissionIframeSrc: "http://95.128.64.231:6886"
    @$el.html(@template(settings))
    @


