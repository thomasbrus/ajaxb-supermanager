class ClubsController < ApplicationController
  skip_before_filter :login_required, only: [:index]

  def index
    @clubs = Club.order('name ASC')

    json = {}

    @clubs.each do |club|
      json[club.shorthand.downcase] = club.name
    end

    respond_to do |format|
      format.json { render json: json }
      format.html { @clubs = Club.order('name ASC') }
    end
  end
end
