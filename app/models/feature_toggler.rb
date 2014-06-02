class FeatureToggler

  include Redis::Objects

  value :submission_active, global: true, marshal: true
  value :feedback_active, global: true, marshal: true
  value :registration_active, global: true, marshal: true
  value :schedule_builder_active, global: true, marshal: true

  def self.clear
    submission_active.delete
    feedback_active.delete
    registration_active.delete
    schedule_builder_active.delete
  end

  def self.activate_submission!
    self.submission_active = true
  end

  def self.activate_feedback!
    self.feedback_active = true
  end

  def self.activate_registration!
    self.registration_active = true
  end

  def self.activate_schedule_builder!
    self.schedule_builder_active = true
  end

  def self.deactivate_submission!
    self.submission_active = false
  end

  def self.deactivate_feedback!
    self.feedback_active = false
  end

  def self.deactivate_registration!
    self.registration_active = false
  end

  def self.deactivate_schedule_builder!
    self.schedule_builder_active = false
  end

  def self.submission_active?
    submission_active.value == true
  end

  def self.feedback_active?
    feedback_active.value == true
  end

  def self.registration_active?
    registration_active.value == true
  end

  def self.schedule_builder_active?
    schedule_builder_active.value == true
  end

end
