#= require utensils/bindable
#= require ./dsw

class dsw.ToggleNav
  constructor: (@el) ->
    @$el = $(@el)
    @addListeners()

  addListeners: ->
    @$el.find('#menu-icon').on 'click', @handleClick
    @$el.find('.close').on 'click', @close


  handleClick: =>
    $('.outer-modal-container').toggleClass('nav-open')


  close: =>
    $('.outer-modal-container').removeClass('nav-open')



utensils.Bindable.register 'toggle-nav', dsw.ToggleNav
