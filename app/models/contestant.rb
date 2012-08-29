class Contestant < ActiveRecord::Base
  attr_accessible :email, :name, :team_id, :team_name
  attr_accessor :team_name
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  belongs_to :team

  def self.sign_up(params)
    contestant = new(params) 
    if params[:team_name].present?
      contestant.team = Team.find_or_initialize_by_name(params[:team_name])
    end
    contestant.save
  end
end
