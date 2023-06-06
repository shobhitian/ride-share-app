# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations-#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(data)
    message_body = data['message']['body']

    # Transform the message body, e.g., convert it to uppercase
    transformed_message = message_body.upcase

    # Broadcast the transformed message to other subscribers
    ActionCable.server.broadcast("conversations-#{current_user.id}", message: transformed_message)
  end
end