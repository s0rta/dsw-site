#= require utensils/bindable
#= require dsw

class dsw.AjaxVoter
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
    @el.on 'ajax:success', 'a', @countVote


  removeListeners: ->
    @el.off 'ajax:success', 'a', @countVote

  countVote: (event, data) =>
    @el.find('.voting-heading').html data.count



utensils.Bindable.register 'ajax-voter', dsw.AjaxVoter

