class AddAuthorIdToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :author_id, :integer
  end
end