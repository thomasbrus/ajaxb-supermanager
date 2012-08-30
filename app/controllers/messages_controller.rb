class MessagesController < ApplicationController
  skip_before_filter :login_required, only: [:new]

  def new
    @message = Message.new
  end

end


