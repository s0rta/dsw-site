module StaticDataHelper
  def featured_static_data
    { features: [] }
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
end
