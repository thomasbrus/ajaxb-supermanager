class Team < ApplicationRecord
  has_many :contestants
  validates_presence_of :name
end
