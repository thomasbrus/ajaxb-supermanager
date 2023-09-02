class CreateLoginRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :login_requests do |t|
      t.datetime :expires_at
      t.string :validation_key
      t.belongs_to :contestant

      t.timestamps
    end
  end
end
