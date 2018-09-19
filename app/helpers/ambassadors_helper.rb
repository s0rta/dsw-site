module AmbassadorsHelper
  def current_ambassadors
    Ambassador.for_current_year
  end
end
