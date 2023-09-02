class AddPositionToPlayerRankings < ActiveRecord::Migration[7.0][5.0]
  def change
    add_column :player_rankings, :position, :integer
  end
end
