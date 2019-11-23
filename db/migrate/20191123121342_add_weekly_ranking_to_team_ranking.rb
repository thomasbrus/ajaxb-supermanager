class AddWeeklyRankingToTeamRanking < ActiveRecord::Migration[5.0]
  def change
    add_reference :team_rankings, :weekly_ranking, foreign_key: true
  end
end
