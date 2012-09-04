class MessagesController < ApplicationController
  skip_before_filter :login_required, only: [:new]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      AdminMailer.contact(@message).deliver
      redirect_to root_path, notice: "E-mail is verzonden!"
    else
      render action: "new"
    end
  end

end


