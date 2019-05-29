class TracksController < ApplicationController
  def show
    @track = Track.find_by(name: params[:name])
    render template: "site/program/track_details"
  end
end