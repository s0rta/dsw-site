module StaticDataHelper
  def featured_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/featured.yml",  __dir__)))
    )
  end

  def secondary_nav_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/secondary_nav.yml",  __dir__)))
    )
  end

  def programs_static_data
    HashWithIndifferentAccess.new(
      YAML.safe_load(File.read(File.expand_path("../data/programs.yml",  __dir__)))
    )
  end
end
