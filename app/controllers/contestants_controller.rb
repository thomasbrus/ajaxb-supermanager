class ContestantsController < ApplicationController
  skip_before_filter :login_required, only: [:new, :create]
  before_filter :admin_rights_required, only: [:index]

  def index
    @contestants = Contestant.order("created_at ASC")
  end

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

  def export
    send_data Contestant.as_csv, type: "text/plain", filename: "deelnemers.csv", disposition: 'attachment'
  end
end
