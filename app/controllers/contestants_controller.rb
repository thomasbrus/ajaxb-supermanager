class ContestantsController < ApplicationController
  skip_before_filter :login_required

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
end
