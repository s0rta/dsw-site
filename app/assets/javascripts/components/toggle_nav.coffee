#= require utensils/bindable
#= require ./dsw

class dsw.ToggleNav
  constructor: (@el) ->
    @$el = $(@el)
    @addListeners()
    @handleScroll()

  addListeners: ->
    @$el.find('#menu-icon').on 'click', @handleClick
    @$el.find('.close').on 'click', @close
    $(window).on 'scroll', @handleScroll

  handleScroll: =>
    if window.scrollY >= 10
      @$el.addClass('shrink')
    else
      @$el.removeClass('shrink')

  handleClick: =>
    $('.outer-modal-container').toggleClass('nav-open')


  close: =>
    $('.outer-modal-container').removeClass('nav-open')

utensils.Bindable.register 'toggle-nav', dsw.ToggleNav
