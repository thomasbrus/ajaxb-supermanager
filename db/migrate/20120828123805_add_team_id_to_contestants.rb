class AddTeamIdToContestants < ActiveRecord::Migration[7.0]
  def change
    add_column :contestants, :team_id, :integer
  end
end
