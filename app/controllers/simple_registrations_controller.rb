class SimpleRegistrationsController < ApplicationController
  render layout: 'new_site'

  def enable
    cookies.permanent.signed[:simple_registration] = true
    render text: 'Simple registration is now ON for this browser.'
  end

  def disable
    cookies.permanent.signed[:simple_registration] = false
    render text: 'Simple registration is now OFF for this browser.'
  end

end
