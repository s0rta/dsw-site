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
      flash[:notice] = 'Thanks for volunteering! You will receive a confirmation e-mail shortly.'
      redirect_to volunteership_path
    else
      respond_with @volunteership
    end
  end

  def edit
    @volunteership = current_user.current_volunteership
    render action: :new
  end

  def update
    @volunteership = current_user.current_volunteership
    if @volunteership.update(volunteership_params)
      flash[:notice] = 'Your changes have been saved. You will receive a confirmation e-mail shortly.'
      redirect_to volunteership_path
    else
      respond_with @volunteership
    end
  end

  def show
  end

  private

  def check_volunteership_open
    unless FeatureToggler.volunteership_active?
      redirect_to dashboard_path,
                  notice: "Volunteer signup for #{Date.today.year} is currently closed"
    end
  end

  def volunteership_params
    params.require(:volunteership).permit(:mobile_phone_number,
                                          :affiliated_organization,
                                          volunteer_shift_ids: [])
  end
end
