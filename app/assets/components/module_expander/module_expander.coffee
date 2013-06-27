#= require utensils/bindable
#= require components/dsw

class dsw.ModuleExpander
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @addListeners()


# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @el.on 'click', '.panel-toggle', => @toggled arguments...

  removeListeners: ->
    @el.off 'click', '.panel-toggle'

  toggled: (e, options) ->
    e.preventDefault()
    module = $(e.target).closest('.module')
    if module.hasClass 'expanded'
      module.removeClass 'expanded'
      module.css width: '32.33%'
    else
      module.addClass 'expanded'
      module.css width: '99%'


utensils.Bindable.register 'module-expander', dsw.ModuleExpander

