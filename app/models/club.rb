class Club < ActiveRecord::Base
  has_many :players
  has_one :coach
  validates_presence_of :name, :shorthand
  validates_uniqueness_of :shorthand
end
