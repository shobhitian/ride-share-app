class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate your account", template_name: "account_activation"
  end
  def otp_email(user, otp)
    @user = user
    @otp = otp
    mail(to: @user.email, subject: 'OTP for Password Reset')
  end
end