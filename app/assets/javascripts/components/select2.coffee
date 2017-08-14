#= require utensils/bindable
#= require ./dsw

class dsw.Select2
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()

  initialize: ->
    @el.select2()

utensils.Bindable.register 'select2', dsw.Select2
