class TracksController < ApplicationController
  def show
    @secondary_nav = HashWithIndifferentAccess.new(YAML.safe_load(
      File.read(File.expand_path("../data/secondary_nav.yml",  __dir__))))

    @featured = HashWithIndifferentAccess.new(YAML.safe_load(
      File.read(File.expand_path("../data/featured.yml",  __dir__))))
    
    @track = Track.find_by(name: params[:name])
      render template: "site/program/track_details"
  end

end