#= require utensils/bindable
#= require ./dsw

class dsw.NewsletterSignup
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
    email = @el.find("input[type='text']").val()
    unless email
      @button.val 'Please supply a valid e-mail address.'
    else
      $.ajax
        url: @el.attr('action')
        type: 'POST'
        dataType: 'json'
        data:
          newsletter_signup:
            email: email
        success: =>
          @button.val 'Thanks! You are signed up for updates.'
        error: =>
          @button.val 'An error occurred - please try again later!'


utensils.Bindable.register 'newsletter-signup', dsw.NewsletterSignup
