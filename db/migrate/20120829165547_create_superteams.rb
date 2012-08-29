class CreateSuperteams < ActiveRecord::Migration
  def change
    create_table :superteams do |t|
      t.belongs_to :contestant

      t.timestamps
    end
    add_index :superteams, :contestant_id
  end
end
