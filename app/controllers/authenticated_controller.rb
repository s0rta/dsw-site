class AuthenticatedController < ApplicationController
  before_action :ensure_linkedin_and_admin!
end
