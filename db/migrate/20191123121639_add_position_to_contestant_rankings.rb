class AddPositionToContestantRankings < ActiveRecord::Migration[5.0]
  def change
    add_column :contestant_rankings, :position, :integer
  end
end
