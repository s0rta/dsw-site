#= require utensils/bindable
#= require dsw

class dsw.SponsorSignup
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
    contactEmail  = @el.find('#sponsor_signup_contact_email').val()
    contactName   = @el.find('#sponsor_signup_contact_name').val()
    company       = @el.find('#sponsor_signup_company').val()
    interest      = @el.find('#sponsor_signup_interest').val()
    notes         = @el.find('#sponsor_signup_notes').val()
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
          sponsor_signup:
            contact_name: contactName
            contact_email:  contactEmail
            company:  company
            interest:      interest
            notes:      notes
        success: =>
          @notification.show()
          @notification.removeClass 'danger'
          @notification.addClass 'success'
          @notification.text 'Thanks for your interest! Our sponsor coordinator will be in touch shortly.'
        error: =>
          @notification.show()
          @notification.removeClass 'success'
          @notification.addClass 'danger'
          @notification.text 'Sorry, an error occurred. Please try again later.'


utensils.Bindable.register 'sponsor-signup', dsw.SponsorSignup
