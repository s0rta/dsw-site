#= require components/dsw
#= require utensils/bindable

class dsw.ModuleTab
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


  initialize: ->
    @panels = @el.find '.tab-panel'
    @nav = @el.find '.tab-navigation'
    @btns = @nav.find 'a'


# PUBLIC #


  toggle: (id) ->
    @togglePanels id
    @toggleNavigation id


  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @btns.on 'click.module_tab', => @triggered arguments...


  removeListeners: ->
    @btns.off 'click.module_tab'


  triggered: (e) ->
    e?.preventDefault()
    @toggle e.target.getAttribute 'href'


  togglePanels: (id) ->
    @panels.removeClass 'active in'
    active = @el.find id
    active.addClass 'active'
    setTimeout(( => active.addClass('in')), 100)


  toggleNavigation: (id) ->
    @btns.removeClass 'active'
    @nav.find("[href=#{id}]").addClass 'active'

utensils.Bindable.register 'module-tab', dsw.ModuleTab

