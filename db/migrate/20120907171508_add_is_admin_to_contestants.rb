class AddIsAdminToContestants < ActiveRecord::Migration[7.0]
  def change
    add_column :contestants, :admin, :boolean, default: false
  end
end
