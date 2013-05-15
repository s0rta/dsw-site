#= require ../menu_filter
fixture.preload 'components/menu_filter/spec/fixture'

describe 'namespace.MenuFilter', ->

  beforeEach ->
    fixture.load 'components/menu_filter/spec/fixture'
    @dom = $(fixture.el)

  it 'is registered in bindable', ->
    #expect(utensils.Bindable.getClass('menu-filter')).to.be namespace.MenuFilter
    #expect(utensils.Bindable.getClass('menu-filter')).toEqual namespace.MenuFilter

  it 'should be tested'
