class LoginRequestsController < ApplicationController
  skip_before_action :login_required, only: %i[new create verify]

  def new
    @login_request = LoginRequest.new
    @email = params[:email] || nil
  end

  def create
    @contestant = Contestant.find_by_email(params[:email].squish.downcase)

    if @contestant.nil?
      @login_request = LoginRequest.new
      @login_request.errors.add(:base, 'Geen account bekend met dit e-mailadres. Waarschijnlijk zul je je eerst moeten registreren.')
      @email = params[:email]
      render action: 'new'
    else
      LoginRequestMailer.login_link(@contestant, @contestant.login_requests.create).deliver
      redirect_to login_link_confirmation_path(email: @contestant.email) and return
    end
  end

  def verify
    @login_request = LoginRequest.find_by_validation_key(params[:validation_key])

    if @login_request.nil? or @login_request.expires_at < Time.now
      redirect_to root_path, alert: 'De loginlink is verlopen of bestaat niet meer. Probeer opnieuw in te loggen.'
    else
      if @login_request.contestant
        login(@login_request.contestant)
        redirect_to my_superteam_path, notice: 'U bent succesvol ingelogd!'
      else
        redirect_to root_path, alert: 'De loginlink is niet aan een account gekoppeld.'
      end
    end
  end
end
