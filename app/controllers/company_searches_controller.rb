class CompanySearchesController < ApplicationController
  def show
    @companies = Company.where('name ILIKE ?', "%#{params[:term]}%")
    render json: { results: @companies.pluck(:name) }.to_json
  end
end
