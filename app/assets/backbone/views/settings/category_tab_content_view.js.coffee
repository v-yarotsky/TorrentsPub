@module 'TorrentsPub.Settings', ->
  class @CategoryTabContentView extends Backbone.View
    template: JST["templates/settings/category_tab_content"]

    className: 'tab-pane'
    id: => "tab-category#{@model.get('id')}"

    events:
      'click button.save': 'save'
      'click button.remove': 'destroy'

    save: (e) =>
      e.preventDefault()
      $form = @$("form")
      data = {
        "name": $form.find("input[name='name']").val()
        "tracker_sections": []
      }
      $form.find(".tracker-section").each ->
        $trackerSection = $(this)
        trackerSection = {
          "tracker_name": $trackerSection.find("select[name='rule_tracker_name']").val()
          "tracker_section": $trackerSection.find("input[name='rule_tracker_section']").val()
          "required_keywords": $trackerSection.find("input[name='rule_required_keywords']").val()
          "denied_keywords": $trackerSection.find("input[name='rule_denied_keywords']").val()
          "min_seeders": $trackerSection.find("input[name='rule_min_seeders']").val()
        }
        data.tracker_sections.push trackerSection

      @model.save data,
        success: -> window.eventDispatcher.trigger('notification:success', message: "Category settings saved")
        error: (model, response) -> window.eventDispatcher.trigger('notification:error', title: "Category was not saved", message: response.responseText)

    destroy: (e) =>
      e.preventDefault()
      @model.destroy
        success: (model, response) ->
          window.eventDispatcher.trigger('notification:success', message: 'Category removed')
          @remove()
        error: (model, response) -> window.eventDispatcher.trigger('notification:error', title: 'Category was not removed', message: response.responseText)

    render: =>
      @$el.html(@template(@model.toViewJSON()))
      trackerSectionsView = new TorrentsPub.Settings.TrackerSectionsView(collection: @model.get('tracker_sections'))
      @$(".tracker-sections").html(trackerSectionsView.render().el)
      @

