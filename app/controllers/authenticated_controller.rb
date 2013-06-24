class AuthenticatedController < ApplicationController

  before_filter :ensure_linkedin_and_admin!

end
