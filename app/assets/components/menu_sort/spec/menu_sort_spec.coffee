#= require ../menu_sort
fixture.preload 'components/menu_sort/spec/fixture'

describe 'namespace.MenuSort', ->

  beforeEach ->
    fixture.load 'components/menu_sort/spec/fixture'
    @dom = $(fixture.el)

  it 'is registered in bindable', ->
    #expect(utensils.Bindable.getClass('menu-sort')).to.be namespace.MenuSort
    #expect(utensils.Bindable.getClass('menu-sort')).toEqual namespace.MenuSort

  it 'should be tested'
