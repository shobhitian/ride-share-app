require_relative '../../lib/push_messenger'


class PushNotificationsController < ApplicationController
    def send_notification
      app_name = params[:app]
      tokens = params[:tokens]
      payload = params[:payload]
  
      if app_name.blank? || tokens.blank? || payload.blank?
        render json: { error: "Invalid parameters" }, status: :unprocessable_entity
        return
      end
  
      push_messenger = determine_push_messenger(app_name)
      if push_messenger.nil?
        render json: { error: "Invalid app name" }, status: :unprocessable_entity
        return
      end
  
      push_messenger.deliver(app_name, tokens, payload)
  
      render json: { message: "Push notification sent successfully" }
    end
  
    private
  
    def determine_push_messenger(app_name)
      case app_name
      when "android_app1"
        PushMessenger::Fcm.new
      when "ios_app"
        PushMessenger::Ios.new
      else
        nil
      end
    end
  end
    