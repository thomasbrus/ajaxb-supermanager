class CoachesController < ApplicationController

  def index
    @coaches = Coach.order('name ASC')

    json = {}
    @coaches.each do |coach|
      json[coach.club.name] ||= {}
      json[coach.club.name][coach.id] = coach.name
    end

    respond_to do |format|
      format.json { render json: json }
    end
  end

end