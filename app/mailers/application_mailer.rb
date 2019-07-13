class ApplicationMailer < ActionMailer::Base
  include ScheduleHelper
  helper ScheduleHelper

  include SendGrid

  default from: "Denver Startup Week <info@email.denverstartupweek.org>",
          reply_to: "Denver Startup Week <info@denverstartupweek.org>"
end
