class ContestantsController < ApplicationController

  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.new(params[:contestant])
    if params[:contestant][:team_name].present?
      @contestant.team = Team.find_or_initialize_by_name(params[:contestant][:team_name])
    end
    if @contestant.save
      redirect_to root_path
    else
      render action: "new"
    end
  end

end
