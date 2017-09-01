class Club < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_one :coach, dependent: :destroy
  validates_presence_of :name, :shorthand
  validates_uniqueness_of :shorthand
end
