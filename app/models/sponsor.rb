class Sponsor < ActiveRecord::Base
  validates_presence_of :logo, :name, :url
end
