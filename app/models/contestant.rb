class Contestant < ActiveRecord::Base
  attr_accessible :email, :name
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  belongs_to :team
end
