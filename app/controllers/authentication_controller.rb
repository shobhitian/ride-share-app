class AuthenticationController < ApplicationController
  

    

    # def phone_signup
    #   @user = User.find_by_phone_number(params[:phone_number])
    
    #   if @user.nil?
    #     # Phone number does not exist, send OTP
    #     otp = generate_otp
    #     # Save the phone number and OTP in a temporary session or cache for later verification
    #     session[:phone_number] = params[:phone_number]
    #     session[:otp] = otp
    
    #     # Send the OTP to the user (e.g., via SMS)
    #     send_otp_to_user(params[:phone_number], otp)
    
    #     render(json: {
    #       status: { code: 200, message: 'OTP sent successfully' }
    #     }, status: :ok)
    #   else
    #     # Phone number already exists, return an error
    #     render(json: {
    #       status: { code: 401, error: 'Phone number already exists' }
    #     }, status: :unauthorized)
    #   end
    # end
  

    def phone  
        @user = User.find_by_phone_number(params[:phone_number])
        
        if @user && @user.send_passcode
          render(json:{
            status: {code: 200, message: 'Sent passccode'}}, status: :ok)
        else
          render(json:{
            status: {code: 401, error: 'failed to send passcode'}}, status: :unauthorized)
        end
      
      end
      
      

      def verify
        @user = User.find_by_phone_number(params[:phone_number])
      
        if @user && @user.verify_passcode(params[:passcode])
          @user.update(phone_verified: true)
          render(json: {
            status: { code: 200, message: 'Phone number verified!' }
          }, status: :ok)
        else
          render(json: {
            status: { code: 401, error: 'Failed to verify passcode' }
          }, status: :unauthorized)
        end
      end
      
      
end
