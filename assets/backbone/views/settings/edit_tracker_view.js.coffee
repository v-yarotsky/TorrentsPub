window.TorrentsPub ?= {}

class TorrentsPub.EditTrackerView extends Backbone.View
  template: JST["templates/settings/edit_tracker"]

  events:
    'click input[type="submit"]': 'save'

  initialize: ->
    @rulesView = new TorrentsPub.RulesView(collection: @model.get('rules'))

  save: (e) =>
    e.preventDefault()
    $form = @$("form")
    data = {
      "tracker_type": $form.find("select[name='tracker_type']").val()
      "login": $form.find("input[name='login']").val()
      "password": $form.find("input[name='password']").val()
      "rules": []
    }
    $form.find(".rule").each ->
      $rule = $(this)
      rule = {
        "category": $rule.find("input[name='rule_category']").val()
        "tracker_section": $rule.find("input[name='rule_tracker_section']").val()
        "required_keywords": $rule.find("input[name='required_keywords']").val()
        "denied_keywords": $rule.find("input[name='denied_keywords']").val()
        "min_seeders": $rule.find("input[name='min_seeders']").val()
      }
      data.rules.push rule

    debugger
    @model.set(data)
    @model.save
      success: =>
        window.eventDispatcher.trigger('notification:success', message: "Tracker settings saved.")
      error: =>
        window.eventDispatcher.trigger('notification:error', message: "Failed to save tracker settings!")
    # xhr = $.ajax
    #   url: @model.url()
    #   type: 'PUT'
    #   data:
    #     "tracker": JSON.stringify(data)
    # xhr.success =>
    # xhr.error =>

  render: =>
    @$el.html(@template(@model.toJSON()))
    @$("#rules").html(@rulesView.render().el)
    @


