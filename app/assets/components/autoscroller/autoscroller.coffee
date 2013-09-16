#= require utensils/bindable
#= require components/dsw

class dsw.Autoscroller
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()


  options: ->


  initialize: ->
    $('html,body').animate({scrollTop: @el.height()}, 20000)

# PUBLIC #

  dispose: ->


# PROTECTED #

  addListeners: ->


  removeListeners: ->


utensils.Bindable.register 'autoscroller', dsw.Autoscroller

