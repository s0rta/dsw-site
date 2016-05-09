#= require jquery
#= require jquery_ujs

#= require utensils/bindable

#= require components/newsletter_signup

createBindable = ->
  utensils.bindable = new utensils.Bindable().bindAll()

disposeBindable = ->
  utensils.bindable.dispose()
  utensils.bindable = null

$(document).on 'ready page:change page:restore', (e) ->
  disposeBindable() if utensils.bindable
  createBindable()
  _gaq.push(['_trackPageview']) if _gaq
