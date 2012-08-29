class LoginRequestsController < ApplicationController
  def verify
    @login_request = LoginRequest.find_by_validation_key(params[:validation_key])
    if @login_request.expires_at < Time.now
      render inline: "Failed..."
    else
      login(@login_request.contestant)
      redirect_to root_path
    end
  end
end
