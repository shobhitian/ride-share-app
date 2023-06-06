class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      ActionCable.server.broadcast("conversations-#{current_user.id}", message: @message)

      redirect_to messages_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
