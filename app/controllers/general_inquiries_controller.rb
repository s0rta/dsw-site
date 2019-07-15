class GeneralInquiriesController < ApplicationController
  skip_before_action :store_location, only: %i[new]

  def new
    @general_inquiry = GeneralInquiry.new
  end

  def create
    @general_inquiry = GeneralInquiry.new(general_inquiry_params)
    if @general_inquiry.save
      flash[:notice] = "Thanks! We will be in touch shortly."
    end
    redirect_to root_path
  end

  private

  def general_inquiry_params
    params
      .require(:general_inquiry)
      .permit(:contact_email,
        :contact_name,
        :company,
        :interest,
        :notes)
  end
end
