class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.integer :code
      t.string :name
      t.references :club

      t.timestamps
    end
    add_index :coaches, :club_id
  end
end
