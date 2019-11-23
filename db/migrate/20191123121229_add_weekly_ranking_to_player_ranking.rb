class AddWeeklyRankingToPlayerRanking < ActiveRecord::Migration[5.0]
  def change
    add_reference :player_rankings, :weekly_ranking, foreign_key: true
  end
end
