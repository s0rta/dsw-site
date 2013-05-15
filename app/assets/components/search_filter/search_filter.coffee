#= require utensils/bindable
#= require components/dsw

class dsw.SearchFilter
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()


  options: ->
    @data.action ?= 'search'


  initialize: ->
    @document = $(document)
    @input = @el.find "input[type='search']"


# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @input.on 'input.searching', => @searching arguments...
    @input.on 'change.searched', => @searched arguments...


  removeListeners: ->
    @input.off 'input.searching'
    @input.off 'change.searched'


  searching: (e) ->
    @document.trigger 'searching', {characters: @input.val()}


  searched: (e) ->
    @document.trigger 'searched', {characters: @input.val()}


utensils.Bindable.register 'search-filter', dsw.SearchFilter

