#= require utensils/bindable

class utensils.NewsletterSignup
  constructor: (@el, data) ->
    @data = if data then data else @el.data()
    @initialize()
    @addListeners()

  initialize: ->


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
    $.ajax
      url: @el.attr('action')
      type: 'POST'
      dataType: 'json'
      data:
        newsletter_signup:
          first_name: @el.find('#newsletter_signup_first_name').val()
          last_name: @el.find('#newsletter_signup_last_name').val()
          email: @el.find('#newsletter_signup_email').val()
      success: =>
        @el.append '<div class="notification success">You have been added to the list! Please check your e-mail for a confirmation.</div>'
      error: =>
        @el.append '<div class="notification danger">An error occurred while trying to add you to the list! Please check your name and e-mail and try again.</div>'
    console.log e


utensils.Bindable.register 'newsletter-signup', utensils.NewsletterSignup

