#= require utensils/bindable
#= require ./dsw

class dsw.AjaxLoadMore
  constructor: (@el, data) ->
    console.log('AjaxLoadMore', @el)
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()


  options: ->


  initialize: ->


# PUBLIC #

  dispose: ->


# PROTECTED #

  addListeners: ->
    @el.on 'ajax:success', 'a.load-more', @appendMore


  removeListeners: ->
    @el.off 'ajax:success', 'a.load-more', @appendMore

  appendMore: (event, data) =>
    @el.before(data.fragment)
    @el.find('a').attr('href', data.next_url)
    @el.hide() if data.fragment.length == 0



utensils.Bindable.register 'ajax-load-more', dsw.AjaxLoadMore
