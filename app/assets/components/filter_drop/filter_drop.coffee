#= require utensils/bindable
#= require components/dsw

class dsw.FilterDrop
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


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
    li = @el.find "[data-filter-by='#{tag}']"
    li.addClass 'active'
    @text.html(filters)


  remove: (tag="", filters="") ->
    li = @el.find "[data-filter-by='#{tag}']"
    li.removeClass 'active'
    @text.html(filters)


  addAll: (tag="", filters="") ->
    @lists.addClass 'active'
    @text.html(filters)


  removeAll: (tag="", filters="") ->
    @lists.removeClass 'active'
    @text.html(filters)


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


  send: (name, options={}) ->
    @document.trigger name, options


  triggered: (e) ->
    e?.preventDefault()
    e?.stopPropagation()
    @toggle()


  filtered: (e) ->
    e?.preventDefault()
    e?.stopPropagation()
    link = $(e.target)
    list = link.closest 'li'
    @send 'filter', {tag: list.data('filter-by')}

utensils.Bindable.register 'filter-drop', dsw.FilterDrop

