class PagesController < ApplicationController
  def home
    @sponsors = Sponsor.all
  end

  def rules
  end
end
