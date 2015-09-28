#= require turbolinks
#= require jquery_ujs
#= require temporal

#= require utensils/bindable
#= require utensils/dismiss

#= require components/ajax_voter
#= require components/filter_bar
#= require components/module_tab
#= require components/newsletter_signup
#= require components/volunteer_signup
#= require components/sponsor_signup
#= require components/carousel
#= require components/module_expander
#= require components/sortable_submissions
#= require components/autoscroller
#= require components/schedule_track_filter
#= require components/schedule_addable_modules
#= require components/event_detail
#= require components/mapquest_map

# Lets get this party started..
createBindable = ->
  utensils.bindable = new utensils.Bindable().bindAll()


disposeBindable = ->
  utensils.bindable.dispose()
  utensils.bindable = null


$(document).on 'ready page:change page:restore', (e) ->
  disposeBindable() if utensils.bindable
  createBindable()
  _gaq.push(['_trackPageview']) if _gaq

$(document).on 'page:fetch', (e) ->
  $('#spinner').addClass 'loading'

