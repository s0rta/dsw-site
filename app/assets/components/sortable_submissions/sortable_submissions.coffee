#= require utensils/bindable
#= require dsw
#= require ./lunr

class dsw.SortableSubmissions
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()

  options: ->
    # No-op

  initialize: ->
    @document = $(document)
    @createIndex()


# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @document.on 'filter:update',  @filtered
    @document.on 'sort:update',  @sorted
    @document.on 'search:update',  @searched

  removeListeners: ->
    @document.off 'filter:update',  @filtered
    @document.off 'sort:update',  @sorted
    @document.off 'search:update',  @searched

  createIndex: =>
    @index = lunr ->
      @ref 'id'
      @field 'title', boost: 10
      @field 'track'
      @field 'day'
      @field 'time'
      @field 'description'
    @updateIndex()

  updateIndex: =>
    index = @index
    @el.find('.module').each ->
      index.add
        id: @id,
        title: @getAttribute('data-title')
        track: @getAttribute('data-track')
        description: @getAttribute('data-description')
        day: @getAttribute('data-day')
        time: @getAttribute('data-time')

  sorted: (event, data) =>
    sortables = @el.find '.module'
    sort = (sortables, type) ->
      sortables.sort (a, b) ->
        a.getAttribute("data-#{type}").localeCompare b.getAttribute("data-#{type}")
    @el.html sort(sortables, data.tag)

  filtered: (event, data) =>
    @filterTags(tag.trim() for tag in data.tags.split(','))

  filterTags: (tags) =>
    categories = {}
    for tag in tags
      [name, value] = tag.split(':')
      if name != ''
        categories[name] or= []
        categories[name].push(value)
    @el.find('.module').each ->
      $module = $(@)
      $module.show()
      for name, values of categories
        $module.hide() unless values.indexOf(@getAttribute("data-#{name}")) >= 0

  searched: (event, data) =>
    console.log data
    if data.terms.length
      @el.find('.module').each ->
        $module = $(@)
        $module.hide()
      results = @index.search(data.terms)
      console.log results
      @el.find("##{result.ref}").show() for result in results
    else
      @el.find('.module').each ->
        $module = $(@)
        $module.show()


utensils.Bindable.register 'sortable-submissions', dsw.SortableSubmissions

