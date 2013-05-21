#= require underscore
#= require utensils/bindable
#= require components/dsw
#= require components/search_filter
#= require components/drop_select
#= require components/menu_filter
#= require components/menu_sort

class dsw.FilterBar
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()


  initialize: ->
    @document = $(document)
    @search_by = ''
    @filter_by = []
    @sort_by = ''
    @filterable = new utensils.Bindable(@el, "filterable").bindAll()


# PUBLIC #

  search: (characters) ->
    @search_by = characters
    @query()


  add: (filter) ->
    @filter_by.push filter
    @query()
    @document.trigger 'filter:update', {action:'add', tag:filter, tags:@stringifyFilters()}


  remove: (filter) ->
    @filter_by.splice _.indexOf(@filter_by, filter), 1
    @query()
    @document.trigger 'filter:update', {action:'remove', tag:filter, tags:@stringifyFilters()}


  sort: (tag) ->
    @sort_by = tag
    @query()
    @document.trigger 'sort:update', {tag:tag, tags:tag}


  query: ->
    console?.log {search: @search_by, filter: @filter_by, sort: @sort_by}


  dispose: ->
    @filterable.dispose()
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @document.on 'searching', => @searched arguments...
    @document.on 'searched', => @searched arguments...
    @document.on 'sort', => @sorted arguments...
    @document.on 'filter', => @filtered arguments...


  removeListeners: ->
    @document.off 'searching'
    @document.off 'searched'
    @document.off 'filter'
    @document.off 'sort'


  searched: (e, options) ->
    @search options.characters


  filtered: (e, options) ->
    return @remove(options.tag) if _.contains @filter_by, options.tag
    @add options.tag


  sorted: (e, options) ->
    @sort options.tag


  stringifyFilters: ->
    "#{@filter_by}".replace /,/g, ", "


utensils.Bindable.register 'filter-bar', dsw.FilterBar

