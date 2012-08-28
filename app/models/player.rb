class Player < ActiveRecord::Base
  belongs_to :club
  attr_accessible :club, :code, :name, :type, :value
  validates_presence_of :club, :code, :name, :type, :value
  validates_uniquness_of :code
end
