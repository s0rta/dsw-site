#= require utensils/bindable
#= require dsw

class dsw.VolunteerSignup
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()

  initialize: ->
    @notification = @el.find('.notification')


# PUBLIC #

  dispose: ->
    @removeListeners()


# PROTECTED #

  addListeners: ->
    @el.bind 'submit', @formWasSubmitted

  removeListeners: ->
    @el.unbind 'submit', @formWasSubmitted

  formWasSubmitted: (e) =>
    e.preventDefault()
    contactEmail  = @el.find('#volunteer_signup_contact_email').val()
    contactName   = @el.find('#volunteer_signup_contact_name').val()
    interest      = @el.find('#volunteer_signup_interest').val()
    notes         = @el.find('#volunteer_signup_notes').val()
    unless contactName and contactEmail
      @notification.show()
      @notification.addClass 'danger'
      @notification.removeClass 'success'
      @notification.text 'Please fill out your name and e-mail address.'
    else
      $.ajax
        url: @el.attr('action')
        type: 'POST'
        dataType: 'json'
        data:
          volunteer_signup:
            contact_name: contactName
            contact_email:  contactEmail
            interest:      interest
            notes:      notes
        success: =>
          @notification.show()
          @notification.removeClass 'danger'
          @notification.addClass 'success'
          @notification.text 'Thanks for your interest! Our volunteer coordinator will be in touch shortly.'
        error: =>
          @notification.show()
          @notification.removeClass 'success'
          @notification.addClass 'danger'
          @notification.text 'Sorry, an error occurred. Please try again later.'


utensils.Bindable.register 'volunteer-signup', dsw.VolunteerSignup
