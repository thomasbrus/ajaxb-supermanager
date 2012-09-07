class AddIsAdminToContestants < ActiveRecord::Migration
  def change
    add_column :contestants, :admin, :boolean, default: false
  end
end
