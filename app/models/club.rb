class Club < ActiveRecord::Base
  has_many :players
  has_one :coach
  attr_accessible :name, :shorthand
  validates_presence_of :name, :shorthand
end
