class CreateCoaches < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches do |t|
      t.integer :code
      t.string :name
      t.references :club

      t.timestamps
    end
  end
end
