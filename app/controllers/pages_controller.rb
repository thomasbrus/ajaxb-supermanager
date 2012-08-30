class PagesController < ApplicationController
  skip_before_filter :login_required, only: [:home, :rules, :thank_you, :login_link_confirmation]

  def home
    @sponsors = Sponsor.all
    @announcements = Announcement.latest
  end

  def rules
  end

  def thank_you
  end

  def login_link_confirmation
  end
end
