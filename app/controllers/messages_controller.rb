# app/controllers/messages_controller.rb

class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]

  def index
    messages = @chat.messages
    render json: { messages: messages }, status: :ok
  end

  def show
    render json: { message: @message }, status: :ok
  end

  def create
    message = @chat.messages.build(message_params)
    message.sender_id = current_user.id # Set sender_id as the current_user's ID
    if message.save
      render json: { message: message }, status: :created
    else
      render json: { error: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      render json: { message: @message }, status: :ok
    else
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    render json: { message: 'Message deleted successfully' }, status: :ok
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :receiver_id)
  end
end
