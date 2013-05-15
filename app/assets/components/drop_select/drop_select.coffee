#= require utensils/bindable
#= require components/dsw

class dsw.DropSelect

  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()


  options: ->
    @data.action ?= 'sort'


  initialize: ->
    @document = $(document)
    @html = $('html')
    @toggler = @el.find '.drop-toggle'
    @text = @toggler.find '.tagged-as'


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


  update: (text) ->
    @text.html text


  dispose: ->
    @removeDocumentListener()
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @document.on "#{@data.action}:update", => @updated arguments...
    @toggler.on 'click.drop_click', => @triggered arguments...


  removeListeners: ->
    @document.off "#{@data.action}:update"
    @toggler.off 'click.drop_click'


  addDocumentListener: ->
    @html.on('click.drop.document', => @hide arguments...)


  removeDocumentListener: ->
    @html.off('click.drop.document')


  triggered: (e) ->
    e?.preventDefault()
    e?.stopPropagation()
    @toggle()


  updated: (e, options) ->
    @update options.tags

utensils.Bindable.register 'drop-select', dsw.DropSelect

