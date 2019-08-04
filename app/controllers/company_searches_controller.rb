class CompanySearchesController < ApplicationController
  def show
    @companies = Company.fuzzy_search(name: params[:term])
    render json: {results: @companies.map(&:name)}.to_json
  end

  def mine
    @companies = current_user.companies.fuzzy_search(name: params[:term])
    render json: {results: @companies.map(&:name)}.to_json
  end
end
