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
    trackSessionSelector = ".#{@filterElementClass}[data-track='#{btn.data('track')}']"
    nonTrackSessionSelector = ".#{@filterElementClass}:not([data-track='#{btn.data('track')}'])"
    if !btn.hasClass('active') && !btn.siblings().is('.active')
      btn.siblings().addClass('active')
      $(document).find(nonTrackSessionSelector).hide()
      $(document).find(trackSessionSelector).show()
    else if !btn.hasClass('active') && btn.siblings().is('.active')
      btn.siblings().removeClass('active')
      $(document).find(nonTrackSessionSelector).show()
      $(document).find(trackSessionSelector).show()
    else
      btn.removeClass('active')
      btn.siblings().addClass('active')
      $(document).find(nonTrackSessionSelector).hide()
      $(document).find(trackSessionSelector).show()


utensils.Bindable.register 'schedule-track-filter', dsw.ScheduleTrackFilter

