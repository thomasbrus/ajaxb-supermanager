class Sponsor < ApplicationRecord
  validates_presence_of :logo, :name, :url
end
