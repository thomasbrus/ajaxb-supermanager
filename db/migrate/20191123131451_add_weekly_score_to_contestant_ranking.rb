class AddWeeklyScoreToContestantRanking < ActiveRecord::Migration[5.0]
  def change
    add_column :contestant_rankings, :weekly_score, :integer
  end
end
