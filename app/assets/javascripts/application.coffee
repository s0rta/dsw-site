#= require jquery
#= require jquery_ujs
#= require underscore

#= require utensils/bindable

#= require components/newsletter_signup
#= require components/general_inquiry
#= require components/toggle_nav
#= require components/toggle_faq
#= require components/ajax_voter
#= require components/ajax_load_more

createBindable = ->
  utensils.bindable = new utensils.Bindable().bindAll()

disposeBindable = ->
  utensils.bindable.dispose()
  utensils.bindable = null

$(document).on 'ready', (e) ->
  disposeBindable() if utensils.bindable
  createBindable()
