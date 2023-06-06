module ApplicationCable
  class Channel < ActionCable::Channel::Base

    def subscribed
      stream_from "conversations-#{current_user.id}"
      # Perform additional setup or broadcasting
    end
    


    def some_method
      # Perform some actions
      message = { body: "Hello, world!" }
      broadcast_to "ChatChannel", message
    end
    

   
  end
end
