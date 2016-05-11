#= require utensils/bindable
#= require ./dsw

class dsw.ToggleFaq
  constructor: (@el) ->
    @$el = $(@el)
    @addListeners()

  addListeners: ->
    @$el.find('.accordion').on 'click', @handleClick

  handleClick: (e) =>
    e.preventDefault()
    $(e.currentTarget).toggleClass('active')
    selector = $(e.currentTarget).next('.panel')
    $(selector).toggleClass('show')

utensils.Bindable.register 'toggle-faq', dsw.ToggleFaq
