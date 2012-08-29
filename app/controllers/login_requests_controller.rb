class LoginRequestsController < ApplicationController
  def verify
    @login_request = LoginRequest.find_by_validation_key(params[:validation_key])
    @login_request.destroy
    if @login_request.expires_at < Time.now
      redirect_to login_path
    else
      login(@login_request.contestant)      
      redirect_to root_path
    end
  end
end
