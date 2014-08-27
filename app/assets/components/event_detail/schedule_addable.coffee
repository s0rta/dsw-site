#= require utensils/bindable
#= require components/dsw

class dsw.ScheduleAddable
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
    @el.on 'click', 'a.add-btn, a.remove-btn', @clicked

  removeListeners: ->
    @el.off 'click', 'a.add-btn, a.remove-btn', @clicked


  clicked: (e) =>
    e?.preventDefault()
    module = $(e.target).closest('.event-details-adder')
    console.log e, module
    console?.log module.data()
    if module.hasClass('added')
      module.removeClass('added')
      $.ajax
        type: 'DELETE'
        url: module.data().removePath
    else
      module.addClass('added')
      $.ajax
        type: 'POST'
        url: module.data().addPath



utensils.Bindable.register 'schedule-addable', dsw.ScheduleAddable
