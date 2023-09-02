class AddPositionToContestantRankings < ActiveRecord::Migration[7.0][5.0]
  def change
    add_column :contestant_rankings, :position, :integer
  end
end
