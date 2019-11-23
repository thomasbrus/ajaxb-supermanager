class AddPositionToPlayerRankings < ActiveRecord::Migration[5.0]
  def change
    add_column :player_rankings, :position, :integer
  end
end
