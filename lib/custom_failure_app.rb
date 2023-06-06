# app/lib/custom_failure_app.rb

class CustomFailureApp < Devise::FailureApp
    def respond
      http_auth? ? http_auth : json_response
    end
  
    def json_response
      self.status = 401
      self.content_type = 'application/json'
      self.response_body = { error: i18n_message }.to_json
    end
  end
  