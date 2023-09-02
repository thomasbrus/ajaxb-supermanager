class Player < ApplicationRecord
  belongs_to :club
  validates_presence_of :club, :code, :name, :type, :value
  validates_uniqueness_of :code

  def position
    nil
  end

  def to_csv
    [code, name, club.shorthand, position]
  end
end
