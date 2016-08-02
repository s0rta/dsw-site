#= require utensils/bindable
#= require ./dsw

class dsw.GeneralInquiry
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()

  initialize: ->
    @button = @el.find('input[type="submit"]')


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
    email = @el.find("#general_inquiry_contact_email").val()
    name = @el.find("#general_inquiry_contact_name").val()
    interest = @el.find("#general_inquiry_interest").val()
    notes = @el.find("#general_inquiry_notes").val()
    unless email && name
      @button.val 'Please supply your name and e-mail address.'
    else
      $.ajax
        url: @el.attr('action')
        type: 'POST'
        dataType: 'json'
        data:
          general_inquiry:
            contact_email: email
            contact_name: name
            interest: interest
            notes: notes
        success: =>
          @button.val 'Thanks! We will be in touch shortly'
        error: =>
          @button.val 'An error occurred - please try again later!'


utensils.Bindable.register 'general-inquiry', dsw.GeneralInquiry
