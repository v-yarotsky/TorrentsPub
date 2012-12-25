@module 'TorrentsPub.Settings', ->
  class @TrackerSectionView extends Backbone.View
    template: JST["templates/settings/tracker_section"]

    tagName: 'div'
    className: 'tracker-section'

    events:
      'click .btn.remove': 'removeTrackerSection'

    removeTrackerSection: (e) =>
      e.preventDefault()
      @model.trigger("destroy")
      @remove()

      false

    render: =>
      @$el.html(@template(@model.toViewJSON()))
      @

