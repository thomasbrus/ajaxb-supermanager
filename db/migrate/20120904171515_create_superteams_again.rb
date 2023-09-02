class CreateSuperteamsAgain < ActiveRecord::Migration[7.0]
  def up
    create_table :superteams do |t|
      t.belongs_to :contestant
      t.belongs_to :coach
      t.belongs_to :bonus_player
      t.belongs_to :goalkeeper
      t.belongs_to :defender_a
      t.belongs_to :defender_b
      t.belongs_to :defender_c
      t.belongs_to :defender_d
      t.belongs_to :midfielder_a
      t.belongs_to :midfielder_b
      t.belongs_to :midfielder_c
      t.belongs_to :forward_a
      t.belongs_to :forward_b
      t.belongs_to :forward_c
      t.timestamps
    end
  end

  def down
    drop_table :superteams
  end
end
