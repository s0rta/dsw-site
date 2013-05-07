#= require utensils/bindable

class utensils.NewsletterSignup
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
    firstName = @el.find('#newsletter_signup_first_name').val()
    lastName  = @el.find('#newsletter_signup_last_name').val()
    email     = @el.find('#newsletter_signup_email').val()
    unless firstName and lastName and email
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
          newsletter_signup:
            first_name: firstName
            last_name:  lastName
            email:      email
        success: =>
          @notification.show()
          @notification.removeClass 'danger'
          @notification.addClass 'success'
          @notification.text 'You have been added to our mailing list. Please check your e-mail for a confirmation.'
        error: =>
          @notification.show()
          @notification.removeClass 'success'
          @notification.addClass 'danger'
          @notification.text 'Sorry, an error occurred while adding you to the list. Please try again later.'


utensils.Bindable.register 'newsletter-signup', utensils.NewsletterSignup
