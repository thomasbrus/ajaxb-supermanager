class ContestantsController < ApplicationController

  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.new(params[:contestant])
    @contestant.team = Team.find_or_create_by_name(params[:contestant][:team_name])
    if @contestant.save
      redirect_to new_formation_path
    else
      render action: "new"
    end
  end

end
