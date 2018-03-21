class GeneralInquiriesController < ApplicationController

  respond_to :json

  def create
    @general_inquiry = GeneralInquiry.new(general_inquiry_params)
    if @general_inquiry.save
      render json: nil, status: :ok
    else
      render json: @general_inquiry.errors, status: :unprocessable_entity
    end
  end

  private

  def general_inquiry_params
    params.require(:general_inquiry).permit(:contact_email,
                                            :contact_name,
                                            :company,
                                            :interest,
                                            :notes)
  end

end
