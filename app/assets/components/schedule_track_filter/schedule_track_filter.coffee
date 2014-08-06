#= require utensils/bindable
#= require components/dsw

class dsw.ScheduleTrackFilter
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


  initialize: ->
    @filterElementClass = @data.filterElementClass


# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @el.on 'click', 'button', @clicked

  removeListeners: ->
    @el.off 'click', 'button', @clicked


  clicked: (e) =>
    e?.preventDefault()
    btn = $(e.target)
    selector = ".#{@filterElementClass}[data-track='#{btn.data('track')}']"
    if btn.hasClass('active')
      btn.removeClass('active')
      $(document).find(selector).show()
    else
      btn.addClass('active')
      $(document).find(selector).hide()



utensils.Bindable.register 'schedule-track-filter', dsw.ScheduleTrackFilter

