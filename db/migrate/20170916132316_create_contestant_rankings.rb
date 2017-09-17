class CreateContestantRankings < ActiveRecord::Migration
  def change
    create_table :contestant_rankings do |t|
      t.string :contestant_name
      t.integer :total_score

      t.timestamps null: false
    end
  end
end
