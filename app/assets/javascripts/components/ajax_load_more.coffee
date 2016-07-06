#= require utensils/bindable
#= require ./dsw

class dsw.AjaxLoadMore
  constructor: (@el, data) ->
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
    @throttledScroll = _.throttle(@handleScroll, 250, { trailingEdge: false })
    $(window).on 'scroll', @throttledScroll

  removeListeners: ->
    @el.off 'ajax:success', 'a.load-more', @appendMore
    $(window).off 'scroll', @throttledScroll

  appendMore: (event, data) =>
    console.log(arguments)
    @el.before(data.fragment)
    @el.find('a').attr('href', data.next_url)
    @el.hide() if data.fragment.length == 0

  handleScroll: (event) =>
    if $(window).scrollTop() > $(document).height() - $(window).height() - 120
      $.ajax(url: @el.find('a').attr('href'), dataType: 'json').then((json) => @appendMore(event,json))


utensils.Bindable.register 'ajax-load-more', dsw.AjaxLoadMore
