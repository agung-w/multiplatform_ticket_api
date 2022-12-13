class ApplicationController < ActionController::Base
    include ActionController::HttpAuthentication::Token
    def authorize_request
        token,_options=token_and_options(request)
        decoded=AuthenticationTokenService.decode(token)
        @current_user=User.find_by!(phone_number:decoded['phone_number'])

        rescue ActiveRecord::RecordNotFound,JWT::DecodeError => e
            render json:{ 
                error: {
                    status: 401,
                    message:e.to_s
                }
            },status: :unauthorized
    end

    def send_otp_wa(user)
        verification=VerificationCode.generate(user)
        client=WhatsappSdk::Api::Client.new(ENV['ACCESS_TOKEN'])
        messages_api = WhatsappSdk::Api::Messages.new(client)
        message_sent = messages_api.send_text(
            sender_id: ENV['SENDER_ID'].to_i, 
            recipient_number: ("62"+user.phone_number).to_i,
            message: "Cinematix account verification code : #{verification.code} "
        )
        if !message_sent.error
            render json: {data:{message:"Verification code sent"}}
        else
            render json: {error:{message:"Cant sent code at the moment"}}, status: :bad_request 
        end
    
    end

    def payload(user)
        {
            'phone_number':user.phone_number,
            'name':user.name,
            'iat':Time.now.to_i
        }
    end
end

