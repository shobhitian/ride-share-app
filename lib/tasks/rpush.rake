namespace :rpush do
    desc "Create Rpush android app"
    task android_app: [:environment] do
      Rpush::Gcm::App.create(name: "android_app1", connections: 2, environment: Rails.env, type: "Rpush::Client::ActiveRecord::Gcm::App", auth_key: 'AAAA4Rc0jBM:APA91bEChNc5KYTHEDQVFgchtuHqV9QZhFfU7JmtQK-hjHTYqQ460srFncoC04bmZaXVSm70aFKtmPA4XjEOQwJZPf1Ytoko3LH8OF1ShSKz-s0vcveY4-T-cfaz7Q8Tfr-N4k9OI8Cd')
      puts "Rpush Android app created Successfully"
    end
  
    desc "Create Rpush Ios app"
    task ios_app: [:environment] do
      Rpush::Gcm::App.create(name: "ios_app", connections: 1, environment: Rails.env, type: "Rpush::Client::ActiveRecord::Gcm::App", auth_key: 'AAAA4Rc0jBM:APA91bEChNc5KYTHEDQVFgchtuHqV9QZhFfU7JmtQK-hjHTYqQ460srFncoC04bmZaXVSm70aFKtmPA4XjEOQwJZPf1Ytoko3LH8OF1ShSKz-s0vcveY4-T-cfaz7Q8Tfr-N4k9OI8Cd', certificate: File.read("config/file_name.p8"))
      puts "Rpush IOS app created Successfully"
    end
  end