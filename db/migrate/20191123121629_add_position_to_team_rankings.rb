class AddPositionToTeamRankings < ActiveRecord::Migration[7.0][5.0]
  def change
    add_column :team_rankings, :position, :integer
  end
end
