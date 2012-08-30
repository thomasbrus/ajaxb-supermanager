class LoginRequestsController < ApplicationController
  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.new(params[:contestant])
    if params[:contestant][:team_name].present?
      @contestant.team = Team.find_or_initialize_by_name(params[:contestant][:team_name])
    end
    if @contestant.save
      ContestantMailer.welcome(@contestant, @contestant.login_requests.create).deliver
      redirect_to thank_you_path
    else
      render action: "new"
    end
  end

  def new
  end

  def create
    @contestant = Contestant.find_by_email(params[:email])

    if @contestant.nil?
      @login_requests.errors.add_to_base "E-mailadres bestaat niet."
    end

    if @login_request.valid?
      LoginRequestMailer.login_link(@contestant, @contestant.login_requests.create).deliver
      flash[:email] = @contestant.email
      redirect_to login_link_sent_path
    else
      render action: "new"
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
