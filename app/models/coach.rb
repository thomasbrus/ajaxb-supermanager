class Coach < ActiveRecord::Base
  belongs_to :club
  attr_accessible :club, :code, :name
  validates_presence_of :code, :name
  validates_uniqueness_of :code
end
