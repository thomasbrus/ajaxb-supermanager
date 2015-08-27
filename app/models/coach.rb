class Coach < ActiveRecord::Base
  belongs_to :club
  has_many :superteams
  validates_presence_of :code, :name
  validates_uniqueness_of :code
end
