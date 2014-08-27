#= require utensils/bindable
#= require components/dsw

class dsw.ScheduleAddable
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


  initialize: ->
    @registrantCount = $('#registrant_count')

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
        dataType: 'json'
        url: module.data().removePath
        success: (json) => @registrantCount.text("#{json} people are attending")
    else
      module.addClass('added')
      $.ajax
        type: 'POST'
        url: module.data().addPath
        success: (json) => @registrantCount.text("#{json} people are attending")



utensils.Bindable.register 'schedule-addable', dsw.ScheduleAddable
