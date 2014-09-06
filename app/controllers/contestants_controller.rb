class ContestantsController < ApplicationController
  skip_before_filter :login_required, only: [:new, :create]
  before_filter :admin_rights_required, only: [:index]

  def index
    @contestants = Contestant.all.sort_by do |contestant|
      if contestant.superteam.present?
        - contestant.superteam.updated_at.to_i
      else
        0
      end
    end
  end

  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.new(params[:contestant])
    @contestant.email = @contestant.email.downcase
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
    send_data Contestant.as_csv, type: "text/csv", filename: "deelnemers.csv", disposition: 'attachment'
  end
end
