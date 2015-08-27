class Player < ActiveRecord::Base
  belongs_to :club
  validates_presence_of :club, :code, :name, :type, :value
  validates_uniqueness_of :code
end

