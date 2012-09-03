class AddPositionsToSuperteam < ActiveRecord::Migration
  def change
    add_column :superteams, :coach_id, :integer
    add_column :superteams, :bonus_player_id, :integer
    add_column :superteams, :goalkeeper_id, :integer
    add_column :superteams, :defender_a_id, :integer
    add_column :superteams, :defender_b_id, :integer
    add_column :superteams, :defender_c_id, :integer
    add_column :superteams, :defender_d_id, :integer
    add_column :superteams, :midfielder_a_id, :integer
    add_column :superteams, :midfielder_b_id, :integer
    add_column :superteams, :midfielder_c_id, :integer
    add_column :superteams, :midfielder_d_id, :integer
    add_column :superteams, :forward_a_id, :integer
    add_column :superteams, :forward_b_id, :integer
    add_column :superteams, :forward_c_id, :integer
  end
end
