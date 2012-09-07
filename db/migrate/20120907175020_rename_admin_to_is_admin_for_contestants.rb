class RenameAdminToIsAdminForContestants < ActiveRecord::Migration
  def change
    rename_column :contestants, :admin, :is_admin
  end
end
