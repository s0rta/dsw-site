#= require turbolinks
#= require utensils/bindable
#= require components/module_tab
#= require components/newsletter_signup
#= require components/carousel

# Lets get this party started..
createBindable = ->
  utensils.bindable = new utensils.Bindable().bindAll()


disposeBindable = ->
  utensils.bindable.dispose()
  utensils.bindable = null


$(document).on 'ready page:change page:restore', (e) ->
  disposeBindable() if utensils.bindable
  createBindable()

