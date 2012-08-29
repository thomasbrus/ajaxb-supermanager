class PagesController < ApplicationController
  def home
    @sponsors = Sponsor.all
    @announcements = Announcement.latest
  end

  def rules
  end

  def thank_you
  end

end
