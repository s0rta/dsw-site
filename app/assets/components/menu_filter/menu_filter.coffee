#= require utensils/bindable
#= require components/dsw

class dsw.MenuFilter
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
    fn = if action is 'add' then 'addClass' else 'removeClass'
    li = @el.find "[data-tag='#{tag}']"
    li[fn] 'active'


  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @links.on 'click.menu_filter', => @filtered arguments...
    @document.on 'filter:update', => @updated arguments...


  removeListeners: ->
    @links.off 'click.menu_filter'
    @document.off 'filter:update'


  filtered: (e) ->
    e?.preventDefault()
    e?.stopPropagation()
    link = $(e.target)
    list = link.closest 'li'
    @document.trigger 'filter', {tag: list.data 'tag'}


  updated: (e, options) ->
    @update options.action, options.tag

utensils.Bindable.register 'menu-filter', dsw.MenuFilter

