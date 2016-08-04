class FeatureToggler

  include Redis::Objects

  TOGGLES = %w(submission feedback registration volunteership).freeze

  TOGGLES.each do |toggle|
    value "#{toggle}_active", global: true, marshal: true

    define_singleton_method "activate_#{toggle}!" do
      send("#{toggle}_active=", true)
    end

    define_singleton_method "deactivate_#{toggle}!" do
      send("#{toggle}_active=", false)
    end

    define_singleton_method "#{toggle}_active?" do
      send("#{toggle}_active").value == true
    end
  end

  def self.clear
    TOGGLES.each do |t|
      send("#{t}_active").delete
    end
  end
end
