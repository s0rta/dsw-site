#= require ../search_filter
fixture.preload 'components/search_filter/spec/fixture'

describe 'namespace.SearchFilter', ->

  beforeEach ->
    fixture.load 'components/search_filter/spec/fixture'
    @dom = $(fixture.el)

  it 'is registered in bindable', ->
    #expect(utensils.Bindable.getClass('search-filter')).to.be namespace.SearchFilter
    #expect(utensils.Bindable.getClass('search-filter')).toEqual namespace.SearchFilter

  it 'should be tested'
