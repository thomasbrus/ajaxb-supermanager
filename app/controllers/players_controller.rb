class PlayersController < ApplicationController
  skip_before_filter :login_required, only: [:index]

  def index
    @players = Club.find(params[:club_id]).players
  end
end
