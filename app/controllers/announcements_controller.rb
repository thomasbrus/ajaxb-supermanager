class AnnouncementsController < ApplicationController
  skip_before_filter :login_required, only: [:index]
  
  def index
    @announcements = Announcement.order('created_at DESC')
  end
end
