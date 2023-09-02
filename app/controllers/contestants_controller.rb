class ContestantsController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :admin_rights_required, only: [:index]

  def index
    @contestants = Contestant.sorted_alphabetically
  end

  def new
    @contestant = Contestant.new
  end

  def create
    # render(text: "Not allowed", status: :method_not_allowed) and return

    @contestant = Contestant.new(contestant_params)
    @contestant.email = @contestant.email.downcase

    @contestant.team = Team.find_or_initialize_by(name: contestant_params[:team_name]) if contestant_params.has_key?(:team_name)

    if @contestant.save
      ContestantMailer.welcome(@contestant, @contestant.login_requests.create).deliver
      redirect_to thank_you_path
    else
      render action: 'new'
    end
  end

  def export
    send_data Contestant.as_csv, type: 'text/csv', filename: 'deelnemers.csv', disposition: 'attachment'
  end

  private def contestant_params
    params.require(:contestant).permit(:email, :name, :team_name, :spam_check)
  end
end
