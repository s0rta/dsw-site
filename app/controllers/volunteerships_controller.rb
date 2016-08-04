class VolunteershipsController < ApplicationController
  respond_to :html
  before_action :check_volunteership_open, only: [ :new, :create ]
  before_action :authenticate_user!

  def new
    @volunteership = current_user.volunteerships.new
  end

  def create
    @volunteership = current_user.volunteerships.new(volunteership_params)
    if @volunteership.save
      flash[:notice] = 'Thanks for volunteering! We will reach out to you shortly to confirm details.'
      redirect_to mine_submissions_path
    else
      respond_with @volunteership
    end
  end

  def show
  end

  private

  def check_volunteership_open
    redirect_to mine_submissions_path unless FeatureToggler.volunteership_active?
  end

  def volunteership_params
    params.require(:volunteership).permit(:mobile_phone_number,
                                          :affiliated_organization,
                                          available_shift_ids: [])
  end
end
