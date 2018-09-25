module TimeHelper

  def local_time_now
    ActiveSupport::TimeZone['America/Denver'].now
  end

end
