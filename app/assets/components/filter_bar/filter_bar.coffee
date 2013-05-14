#= require underscore
#= require utensils/bindable
#= require components/dsw
#= require components/filter_drop

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
    @search_field = @el.find '#search_bar'
    @filterable = new utensils.Bindable(@el, "filterable").bindAll()
    @filterables = @filterable.getRefs()


# PUBLIC #

  search: (chars="") ->
    @search_by = chars
    @request()


  addFilter: (filter, requester) ->
    @filter_by.push filter
    requester.add filter, @stringifyFilters()
    @request()


  removeFilter: (filter, requester) ->
    @filter_by.splice _.indexOf(@filter_by, filter), 1
    requester.remove filter, @stringifyFilters()
    @request()


  sort: (tag, requester) ->
    @sort_by = tag
    requester.removeAll()
    requester.add tag, @sort_by
    @request()


  request: ->
    console?.log {search: @search_by, filter: @filter_by, sort: @sort_by}


  dispose: ->
    @filterable.dispose()
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @search_field.on 'input.search', => @searched arguments...
    @document.on 'filter', => @filtered arguments...
    @document.on 'sort', => @sorted arguments...


  removeListeners: ->
    @search_field.off 'input.search'
    @document.off 'filter'
    @document.off 'sort'


  searched: (e) ->
    @search @search_field.val()


  filtered: (e, options) ->
    return @removeFilter(options.tag, options.requester) if _.contains @filter_by, options.tag
    @addFilter options.tag, options.requester


  sorted: (e, options) ->
    @sort options.tag, options.requester


  stringifyFilters: ->
    "#{@filter_by}".replace /,/g, ", "


utensils.Bindable.register 'filter-bar', dsw.FilterBar

