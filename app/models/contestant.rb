class Contestant < ActiveRecord::Base
  attr_accessor :team_name
  attr_accessible :email, :name, :team_id, :team_name
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  belongs_to :team
  has_one :superteam
  has_many :login_requests, dependent: :destroy

  def name_with_team
    if team.present?
      "#{name} (#{team.name})"
    else
      name
    end
  end
end
