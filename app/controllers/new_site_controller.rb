class NewSiteController < ApplicationController
  def index
    render template: "new_site/#{params[:page]}", layout: 'new_site'
  end
end
