class PagesController < ApplicationController
  def home
    @sponsors = Sponsor.all
    @announcements = Announcement.latest
  end

  def rules
  end
end
