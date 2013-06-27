#= require ../sortable_submissions
fixture.preload 'components/sortable_submissions/spec/fixture'

describe 'namespace.SortableSubmissions', ->

  beforeEach ->
    fixture.load 'components/sortable_submissions/spec/fixture'
    @dom = $(fixture.el)

  it 'is registered in bindable', ->
    #expect(utensils.Bindable.getClass('sortable-submissions')).to.be namespace.SortableSubmissions
    #expect(utensils.Bindable.getClass('sortable-submissions')).toEqual namespace.SortableSubmissions

  it 'should be tested'
