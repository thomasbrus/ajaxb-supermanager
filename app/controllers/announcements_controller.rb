class AnnouncementsController < ApplicationController
  skip_before_filter :login_required, only: [:index]
  before_filter :admin_rights_required, except: [:index]

  def index
    @announcements = Announcement.order('created_at DESC')
  end

  def new
    @announcement = Announcement.new
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.author = @current_contestant

    if @announcement.save
      redirect_to root_path, notice: 'De nieuwe mededeling is toegevoegd!'
    else
      render action: "new"
    end
  end

  def update
    @announcement = Announcement.find(params[:id])

    if @announcement.update_attributes(announcement_params)
      redirect_to announcements_path, notice: 'De mededeling is bijgewerkt.'
    else
      render action: "edit"
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to announcements_path, notice: 'De mededeling is verwijderd.'
  end

  private def announcement_params
    params.require(:announcement).permit(:content, :title)
  end
end
