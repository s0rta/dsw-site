#= require utensils/bindable
#= require components/dsw

class dsw.FilterDrop
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()


  options: ->
    @data.behavior ?= 'radio'
    @data.action ?= 'sort'

  initialize: ->
    @document = $(document)
    @html = $('html')
    @toggler = @el.find '.drop-toggle'
    @text = @toggler.find '.tagged-as'
    @lists = @el.find '.drop-menu li'
    @links = @lists.find 'a'


# PUBLIC #

  show: ->
    @el.addClass 'active'
    @addDocumentListener()
    true


  hide: ->
    @el.removeClass 'active'
    @removeDocumentListener()
    false


  toggle: ->
    return @hide() if @el.hasClass 'active'
    @show()


  add: (tag="", filters="") ->
    @updateFilter tag, filters, 'addClass'


  remove: (tag="", filters="") ->
    @updateFilter tag, filters, 'removeClass'


  addAll: (tag="", filters="") ->
    @updateFilters tag, filters, 'addClass'


  removeAll: (tag="", filters="") ->
    @updateFilters tag, filters, 'removeClass'


  dispose: ->
    @removeAll()
    @removeDocumentListener()
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @toggler.on 'click.drop_click', => @triggered arguments...
    @lists.on 'click.filter_click', => @filtered arguments...


  removeListeners: ->
    @toggler.off 'click.drop_click'
    @lists.off 'click.filter_click'


  addDocumentListener: ->
    @html.on('click.drop.document', => @hide arguments...)


  removeDocumentListener: ->
    @html.off('click.drop.document')


  updateFilter: (tag, filters, fn) ->
    li = @el.find "[data-filter-by='#{tag}']"
    li[fn]('active')
    @text.html filters


  updateFilters: (tag, filters, fn) ->
    @lists[fn] 'active'
    @text.html filters


  send: (name, options={}) ->
    @document.trigger name, options


  triggered: (e) ->
    e?.preventDefault()
    e?.stopPropagation()
    @toggle()


  filtered: (e) ->
    e?.preventDefault()
    e?.stopPropagation() if @data.behavior is 'checkbox'
    link = $(e.target)
    list = link.closest 'li'
    @send @data.action, {tag: list.data('filter-by'), requester: @}


utensils.Bindable.register 'filter-drop', dsw.FilterDrop

