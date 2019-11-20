class RankingsController < ApplicationController
  skip_before_action :login_required, only: [:show]
  before_action :admin_rights_required, except: [:show]

  def show
    @date = Date.today.beginning_of_week(:sunday)
    @contestant_rankings = ContestantRanking.order(total_score: :desc, contestant_name: :asc)
    @team_rankings = TeamRanking.order(score: :desc, team_name: :asc)
    @player_rankings = PlayerRanking.order(score: :desc, player_name: :asc)
  end

  def edit
  end

  def update
    contents = params.fetch(:ranking).read

    ActiveRecord::Base.transaction do
      ContestantRanking.destroy_all
      ContestantRanking.parse(contents).each(&:save!)

      TeamRanking.destroy_all
      TeamRanking.parse(contents).each(&:save!)

      PlayerRanking.destroy_all
      PlayerRanking.parse(contents).each(&:save!)
    end

    redirect_to ranking_path, notice: 'De stand is bijgewerkt.'
  end
end
