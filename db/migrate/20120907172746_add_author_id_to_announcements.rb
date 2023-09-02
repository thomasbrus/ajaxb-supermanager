class AddAuthorIdToAnnouncements < ActiveRecord::Migration[7.0]
  def change
    add_column :announcements, :author_id, :integer
  end
end
