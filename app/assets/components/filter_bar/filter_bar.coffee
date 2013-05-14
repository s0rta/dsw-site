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
    @filters = []
    @filterable = new utensils.Bindable(@el, "filterable").bindAll()
    @filterables = @filterable.getRefs()


# PUBLIC #

  addFilter: (filter) ->
    @filters.push filter
    filterable.add(filter, "#{@filters} ") for filterable in @filterables


  removeFilter: (filter) ->
    @filters.splice _.indexOf(@filters, filter), 1
    filterable.remove(filter, "#{@filters} ") for filterable in @filterables


  dispose: ->
    @filterable.dispose()
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @document.on 'filter', => @filtered arguments...


  removeListeners: ->
    @document.off 'filter'


  filtered: (e, options) ->
    return @removeFilter(options.tag) if _.contains @filters, options.tag
    @addFilter options.tag


utensils.Bindable.register 'filter-bar', dsw.FilterBar

