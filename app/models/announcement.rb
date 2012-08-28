class Announcement < ActiveRecord::Base
  attr_accessible :content, :title
  validates_presence_of :content, :title
  scope :latest, order('created_at DESC').limit(2)

  def author
    "Site Admin"
  end
end
