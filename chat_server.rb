require 'sinatra'
require 'redis'
require 'json'

# Create a Redis client
redis = Redis.new

# Subscribe to a Redis channel
Thread.new do
  redis.subscribe('chat') do |on|
    on.message do |channel, message|
      # Broadcast the received message to all connected clients
      settings.connections.each { |out| out << message }
    end
  end
end

# Store client connections
configure do
  set :connections, []
end

# Define an endpoint for WebSocket connection
get '/chat' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        # Store the WebSocket connection
        settings.connections << ws
      end

      ws.onmessage do |message|
        # Publish the received message to the Redis channel
        redis.publish('chat', message)
      end

      ws.onclose do
        # Remove the WebSocket connection
        settings.connections.delete(ws)
      end
    end
  end
end
