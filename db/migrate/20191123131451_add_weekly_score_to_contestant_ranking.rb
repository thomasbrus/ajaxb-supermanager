class AddWeeklyScoreToContestantRanking < ActiveRecord::Migration[7.0][5.0]
  def change
    add_column :contestant_rankings, :weekly_score, :integer
  end
end
