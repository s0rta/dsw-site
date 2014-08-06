#= require utensils/bindable
#= require components/dsw

class dsw.ScheduleAddableModules
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


  initialize: ->
    # No-op

# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @el.on 'click', '[data-addable]', @clicked

  removeListeners: ->
    @el.off 'click', '[data-addable]', @clicked


  clicked: (e) =>
    e?.preventDefault()
    module = $(e.target).closest('.schedule-module')
    console?.log module.data()
    if module.hasClass('schedule-selected')
      module.removeClass('schedule-selected')
      $.ajax
        type: 'DELETE'
        url: module.data().removePath
    else
      module.addClass('schedule-selected')
      $.ajax
        type: 'POST'
        url: module.data().addPath



utensils.Bindable.register 'schedule-addable-modules', dsw.ScheduleAddableModules

