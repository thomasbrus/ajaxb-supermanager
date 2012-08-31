class ClubsController < ApplicationController
  skip_before_filter :login_required, only: [:index]
  def index
    @clubs = Club.order('name ASC')
  end
end
