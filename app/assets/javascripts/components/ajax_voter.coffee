#= require utensils/bindable
#= require ./dsw

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
    @el.on 'ajax:success', 'a.register-vote', @countVote


  removeListeners: ->
    @el.off 'ajax:success', 'a.register-vote', @countVote

  countVote: (event, data) =>
    noun = if data.count == 1 then 'vote' else 'votes'
    @el.find('.vote-count').html("#{data.count} #{noun}")



utensils.Bindable.register 'ajax-voter', dsw.AjaxVoter
