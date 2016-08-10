class HelpscoutHooksController < ApplicationController

  before_action :verify_helpscout_signature!
  skip_before_filter :verify_authenticity_token

  def create
    @user = User.where(email: params[:customer][:emails]).first
    render json: { html: render_to_string(partial: 'helpscout_fragment') }.to_json
  end

  private

  def verify_helpscout_signature!
    signature = request.headers['HTTP_X_HELPSCOUT_SIGNATURE']
    if request.body.nil? || signature.nil?
      head :unauthorized
    else
      hmac = OpenSSL::HMAC.digest('sha1', ENV['HELPSCOUT_WEBHOOK_SECRET_KEY'], request.body.read)
      head :unauthorized unless Base64.encode64(hmac).strip == signature.strip
    end
  end
end
