class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.integer :code
      t.string :name
      t.references :club
      t.string :type
      t.integer :value

      t.timestamps
    end
  end
end
