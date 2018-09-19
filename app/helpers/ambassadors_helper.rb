module AmbassadorsHelper
  def current_ambassadors
    Ambassador.for_current_year.order('last_name DESC')
  end
end
