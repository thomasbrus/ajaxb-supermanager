class LoginRequestsController < ApplicationController
  skip_before_filter :login_required, only: [:new, :create, :verify]

  def new
    @login_request = LoginRequest.new
  end

  def create
    @contestant = Contestant.find_by_email(params[:email])
    if @contestant.nil?
      @login_request = LoginRequest.new
      @login_request.errors[:base] << "E-mailadres bestaat niet."
      @email = params[:email]
      render action: "new"
    else
      LoginRequestMailer.login_link(@contestant, @contestant.login_requests.create).deliver
      flash[:email] = @contestant.email
      redirect_to login_link_confirmation_path and return
    end
  end

  def verify
    @login_request = LoginRequest.find_by_validation_key(params[:validation_key])
    @login_request.try(:destroy)
    if @login_request.nil? or @login_request.expires_at < Time.now
      redirect_to root_path, alert: "De loginlink is verlopen of bestaat niet meer. Probeer opnieuw in te loggen."
    else
      login(@login_request.contestant)      
      redirect_to root_path, notice: "U bent succesvol ingelogd!"
    end
  end
end
