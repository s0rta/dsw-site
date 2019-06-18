module StaticDataHelper
  def featured_static_data
    data = HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/featured.yml",  __dir__)))
    ).deep_transform_keys(&:to_sym)
    puts data[:features].first[:tracks].first[:name]
    data
  end

  def secondary_nav_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/secondary_nav.yml",  __dir__)))
    ).deep_transform_keys(&:to_sym)
  end

  def programs_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/programs.yml",  __dir__)))
    ).deep_transform_keys(&:to_sym)
  end

  def about_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/about.yml",  __dir__)))
    ).deep_transform_keys(&:to_sym)
  end

  def get_involved_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/get_involved.yml",  __dir__)))
    ).deep_transform_keys(&:to_sym)
  end
end
