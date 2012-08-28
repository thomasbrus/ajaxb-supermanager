class Sponsor < ActiveRecord::Base
  attr_accessible :logo, :name, :url
  validates_presence_of :logo, :name, :url
end
