class ContestantsController < ApplicationController

  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.register(params[:contestant])
    if @contestant
      LoginKey.request(@contestant)
      LoginKeyEmailer.deliver
      redirect_to thank_you_path
    else
      render action: "new"
    end
  end
end
