class GeneralInquiriesController < ApplicationController
  skip_before_action :store_location, only: %i[new]

  def new
    @general_inquiry = GeneralInquiry.new
  end

  def create
    @general_inquiry = GeneralInquiry.new(general_inquiry_params)

    if verify_recaptcha(action: "contact",
                        model: @general_inquiry,
                        minimum_score: recaptcha_min_score) && @general_inquiry.save
      flash[:notice] = "Thanks! We will be in touch shortly."
      redirect_to root_path
    else
      render action: :new
    end
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
