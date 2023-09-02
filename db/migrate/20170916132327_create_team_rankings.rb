class CreateTeamRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :team_rankings do |t|
      t.string :team_name
      t.integer :score

      t.timestamps null: false
    end
  end
end
