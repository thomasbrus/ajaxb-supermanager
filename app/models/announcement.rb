class Announcement < ActiveRecord::Base
  belongs_to :author, class_name: 'Contestant'
  validates_presence_of :content, :title, :author
  scope :latest, -> { order(created_at: :desc).limit(3) }
end
