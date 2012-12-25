@module 'TorrentsPub.Settings', ->
  class @TrackerSectionsView extends Backbone.View
    template: JST["templates/settings/tracker_sections"]

    className: 'well form-inline'
    tagName: 'div'

    events:
      'click .btn.add': 'add'


    initialize: ->
      @collection.bind("reset", @render)
      @collection.bind("add", @renderItem)
      @render()

    add: (e) =>
      e.preventDefault()
      @collection.push(new TorrentsPub.TrackerSection())
      false

    renderItem: (tracker_section) =>
      itemView = new TorrentsPub.Settings.TrackerSectionView(model: tracker_section)
      @$el.append(itemView.render().el)

    render: =>
      @$el.html(@template())
      @renderItem(tracker_section) for tracker_section in @collection.models
      @

