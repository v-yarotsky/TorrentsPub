window.TorrentsPub ?= {}
window.TorrentsPub.Settings ?= {}

class TorrentsPub.Settings.CategoryTabContentView extends Backbone.View
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
      "rules": []
    }
    $form.find(".rule").each ->
      $rule = $(this)
      rule = {
        "tracker_name": $rule.find("select[name='rule_tracker_name']").val()
        "tracker_section": $rule.find("input[name='rule_tracker_section']").val()
        "required_keywords": $rule.find("input[name='rule_required_keywords']").val()
        "denied_keywords": $rule.find("input[name='rule_denied_keywords']").val()
        "min_seeders": $rule.find("input[name='rule_min_seeders']").val()
      }
      data.rules.push rule

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
    rulesView = new TorrentsPub.Settings.RulesView(collection: @model.get('rules'))
    @$(".rules").html(rulesView.render().el)
    @




