class Team < ActiveRecord::Base
  attr_accessible :name
  has_many :contestants
  validates_presence_of :name
end
