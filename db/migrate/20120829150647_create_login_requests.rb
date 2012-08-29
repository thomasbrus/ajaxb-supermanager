class CreateLoginRequests < ActiveRecord::Migration
  def change
    create_table :login_requests do |t|
      t.datetime :expires_at
      t.string :validation_key
      t.belongs_to :contestant

      t.timestamps
    end
    add_index :login_requests, :contestant_id
  end
end
