#= require utensils/bindable
#= require components/dsw

class dsw.Carousel
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @options()
    @initialize()
    @addListeners()
    @activate @index


  options: ->
    @data.keyboard = true unless @data.keyboard is false
    @index = if @data.activate then @data.activate else 0


  initialize: ->
    @slider = @el.find '.form-carousel-inner'
    @panels = @slider.find '.form-pane'
    @num_panels = @panels.length
    @setProperWidths()
    @indicators = @createIndicators()


# PUBLIC #

  next: (e, data) ->
    e?.preventDefault()
    @activate @index + 1


  prev: (e) ->
    e?.preventDefault()
    @activate @index - 1


  activate: (index=0) ->
    @index = index
    @constrainIndex()
    @slider.css 'margin-left', "#{-(@index * 100)}%"
    @indicators.removeClass 'active'
    @indicators.eq(@index).addClass 'active'


  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    $('html').on('keydown.carousel', => @keyed arguments...) if @data.keyboard
    @indicators.on 'click.carousel', => @indicated arguments...


  removeListeners: ->
    $('html').off('keydown.carousel') if @data.keyboard
    @indicators.off 'click.carousel'


  keyed: (e) ->
    return if (!/(37|39)/.test(e.keyCode))
    e?.preventDefault()
    @prev(e) if e.keyCode is 37
    @next(e) if e.keyCode is 39


  indicated: (e) ->
    e?.preventDefault()
    @activate $(e.target).index()


  setProperWidths: ->
    @slider.width "#{100 * @num_panels}%"
    @panels.width "#{100 / @num_panels}%"


  createIndicators: ->
    markup = ''
    indication = @el.find '.carousel-controls'
    for i in [1..@num_panels]
      markup += "<a class='indicator' href='#slide_#{i}'></a>"
    indication.append markup
    indication.find 'a'


  constrainIndex: ->
    @index = 0 if @index >= @num_panels
    @index = @num_panels - 1 if @index < 0

utensils.Bindable.register 'dsw-carousel', dsw.Carousel

