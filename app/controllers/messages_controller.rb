class MessagesController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      AdminMailer.contact(@message).deliver
      redirect_to root_path, notice: "E-mail is verzonden!"
    else
      render action: "new"
    end
  end

  private def message_params
    params.require(:message).permit(:name, :email, :content, :receipent)
  end
end


