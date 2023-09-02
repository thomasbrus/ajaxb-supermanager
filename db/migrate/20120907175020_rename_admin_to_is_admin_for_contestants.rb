class RenameAdminToIsAdminForContestants < ActiveRecord::Migration[7.0]
  def change
    rename_column :contestants, :admin, :is_admin
  end
end
