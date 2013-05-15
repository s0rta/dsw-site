#= require utensils/bindable
#= require components/dsw

class dsw.MenuSort
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


  initialize: ->
    @document = $(document)
    @lists = @el.find 'li'
    @links = @lists.find 'a'


# PUBLIC #

  update: (action, tag) ->
    @lists.removeClass 'active'
    li = @el.find "[data-tag='#{tag}']"
    li.addClass('active')


  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @links.on 'click.menu_filter', => @sorted arguments...
    @document.on 'sort:update', => @updated arguments...


  removeListeners: ->
    @links.off 'click.menu_filter'
    @document.off 'sort:update'


  sorted: (e) ->
    e?.preventDefault()
    link = $(e.target)
    list = link.closest 'li'
    @document.trigger 'sort', {tag: list.data 'tag'}


  updated: (e, options) ->
    @update options.action, options.tag


utensils.Bindable.register 'menu-sort', dsw.MenuSort

