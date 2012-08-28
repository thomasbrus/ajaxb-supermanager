class Contestant < ActiveRecord::Base
  attr_accessible :email, :name, :team_id, :team_name
  attr_accessor :team_name
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  belongs_to :team
end
