class CompanySearchesController < ApplicationController
  before_action :set_minimum_match_threshold

  def show
    @companies = Company.fuzzy_search(name: params[:term])
    render json: {results: @companies.map(&:name)}.to_json
  end

  def mine
    @companies = current_user.companies.fuzzy_search(name: params[:term])
    render json: {results: @companies.map(&:name)}.to_json
  end

  private

  def set_minimum_match_threshold
    ActiveRecord::Base.connection.execute("SELECT set_limit(0.1);")
  end
end
