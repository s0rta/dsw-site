#= require ../drop_select
fixture.preload 'components/drop_select/spec/fixture'

describe 'namespace.DropSelect', ->

  beforeEach ->
    fixture.load 'components/drop_select/spec/fixture'
    @dom = $(fixture.el)

  it 'is registered in bindable', ->
    #expect(utensils.Bindable.getClass('drop-select')).to.be namespace.DropSelect
    #expect(utensils.Bindable.getClass('drop-select')).toEqual namespace.DropSelect

  it 'should be tested'
