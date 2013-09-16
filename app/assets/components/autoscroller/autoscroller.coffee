#= require utensils/bindable
#= require components/dsw

class dsw.Autoscroller

  constructor: (@el, data) ->
    @scrollTime = parseFloat(@el.data('scroll-time'))
    @initialize()
    @addListeners()

  initialize: =>
    @currentIndex = 0
    @eventCount = @el.find('section').length
    @animateNext()

  animateNext: =>
    if @currentIndex < @eventCount
      currentEl = $(@el.find('section').get(@currentIndex))
      $('html,body').animate({scrollTop: currentEl.position().top}, 250)
    else
      @currentIndex = 0
      $('html,body').animate({scrollTop: 0}, 250)
    @currentIndex += 1
    setTimeout @animateNext, @scrollTime * 1000


# PUBLIC #

  dispose: ->


# PROTECTED #

  addListeners: ->


  removeListeners: ->


utensils.Bindable.register 'autoscroller', dsw.Autoscroller

