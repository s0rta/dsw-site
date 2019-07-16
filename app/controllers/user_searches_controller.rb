class UserSearchesController < ApplicationController
  def show
    @users = User.where('name ILIKE ?', "%#{params[:term]}%")
    results = @users.map { |u| { label: u.name, value: u.id } }
    render json: { results: results }.to_json
  end
end
