window.TorrentsPub ?= {}

class TorrentsPub.Tracker extends Backbone.Model
  urlRoot: 'trackers'
  defaults:
    name: "Fuck Bill Gates"
    login_url: 'http://google.com'
    login: 'vasya'
    password: 'pupkin'

