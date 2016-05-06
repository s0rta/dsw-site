class NewSiteController < ApplicationController
  def index
    render template: "new_site/#{params[:page]}"
  end
end
