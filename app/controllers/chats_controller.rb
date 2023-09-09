# app/controllers/chats_controller.rb

class ChatsController < ApplicationController
    before_action :set_chat, only: [:show, :update, :destroy]
  
    def index
      chats = Chat.all
      render json: { chats: chats }, status: :ok
    end
  
    def show
      render json: { chat: @chat }, status: :ok
    end
  
    def create
        chat = Chat.new(chat_params)
        chat.sender_id = current_user.id
        if chat.save
          render json: { chat: chat }, status: :created
        else
          render json: { error: chat.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
  
    def update
      if @chat.update(chat_params)
        render json: { chat: @chat }, status: :ok
      else
        render json: { error: @chat.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @chat.destroy
      render json: { message: 'Chat deleted successfully' }, status: :ok
    end
  
    private
  
    def set_chat
      @chat = Chat.find(params[:id])
    end
  
    def chat_params
      params.require(:chat).permit(:receiver_id)
    end
  end
  