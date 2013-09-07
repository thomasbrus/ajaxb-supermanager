class Announcement < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :author, class_name: 'Contestant'
  validates_presence_of :content, :title, :author
  scope :latest, order('created_at DESC').limit(3)
end
