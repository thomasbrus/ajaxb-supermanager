class DropPlayersSuperteams < ActiveRecord::Migration
  def up
    drop_table :players_superteams
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
