class SimpleRegistrationsController < ApplicationController

  def enable
    cookies.permanent.signed[:simple_registration] = true
    render plain: 'Simple registration is now ON for this browser.'
  end

  def disable
    cookies.permanent.signed[:simple_registration] = false
    render plain: 'Simple registration is now OFF for this browser.'
  end

end
