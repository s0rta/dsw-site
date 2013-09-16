#= require utensils/bindable
#= require components/dsw

class dsw.Autoscroller
  constructor: (@el, data) ->

    @scrollTime = parseInt(@el.data('scroll-time'), 10)
    @initialize()
    @addListeners()

  initialize: =>
    console.log @scrollTime
    cb = =>
      $('html,body').animate({scrollTop: @el.height()}, @scrollTime * 1000)
    setTimeout cb, 2000

# PUBLIC #

  dispose: ->


# PROTECTED #

  addListeners: ->


  removeListeners: ->


utensils.Bindable.register 'autoscroller', dsw.Autoscroller

