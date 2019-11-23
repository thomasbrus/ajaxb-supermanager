class AddPositionToTeamRankings < ActiveRecord::Migration[5.0]
  def change
    add_column :team_rankings, :position, :integer
  end
end
