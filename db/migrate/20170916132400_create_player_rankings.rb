class CreatePlayerRankings < ActiveRecord::Migration
  def change
    create_table :player_rankings do |t|
      t.string :player_name
      t.string :player_club
      t.string :player_position
      t.integer :player_value
      t.integer :score

      t.timestamps null: false
    end
  end
end
