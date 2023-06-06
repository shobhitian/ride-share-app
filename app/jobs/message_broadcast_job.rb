class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    payload = render_message(message)
    ActionCable.server.broadcast("chat_channel", payload)
  end

  def render_message(message)
    # Customize how the message is rendered before sending it to clients
    # For example, you can include additional attributes or associations
    {
      id: message.id,
      content: message.content,
      sender: {
        id: message.sender.id,
        name: message.sender.name
      },
      created_at: message.created_at
    }
  end
end
