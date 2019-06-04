class CompanySearchesController < ApplicationController
  def show
    @companies = Company.where("name ILIKE ?", "%#{params[:term]}%")
    render json: {results: @companies.pluck(:name)}.to_json
  end

  def mine
    @companies = current_user.companies.where("name ILIKE ?", "%#{params[:term]}%")
    render json: {results: @companies.pluck(:name)}.to_json
  end
end
