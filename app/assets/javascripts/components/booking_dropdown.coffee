#= require utensils/bindable
#= require ./dsw

class dsw.BookingDropdown
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @addListeners()


# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @el.bind 'submit', @formWasSubmitted

  removeListeners: ->
    @el.unbind 'submit', @formWasSubmitted

  formWasSubmitted: (e) =>
    e.preventDefault()
    url = $(e.target).find('select').val()
    window.location.href = url


utensils.Bindable.register 'booking-dropdown', dsw.BookingDropdown
