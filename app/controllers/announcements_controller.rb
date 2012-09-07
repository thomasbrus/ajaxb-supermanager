class AnnouncementsController < ApplicationController
  skip_before_filter :login_required, only: [:index]
  before_filter :admin_rights_required, only: [:new, :create, :edit, :update]

  def index
    @announcements = Announcement.order('created_at DESC')
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(params[:announcement])
    if @announcement.save
      redirect_to root_path, notice: 'De nieuwe mededeling is toegevoegd!'
    else
      render action: "new"
    end
  end
end
