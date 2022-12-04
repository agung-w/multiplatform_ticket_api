class Authentication::AuthController < ApplicationController
    skip_before_action :verify_authenticity_token
    def omniauth
        user=User.from_omniauth(request.env['omniauth.auth'])
        if user.valid?
            token = AuthenticationTokenService.encode(payload(user))
            render json: { token: token}, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def login_by_phone
        user=User.find_by(phone_number:login_params[:phone_number])
        if user&.authenticate(login_params[:password]) 
            token = AuthenticationTokenService.encode(payload(user))
            render json: { token: token}, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def register_by_phone
        user=User.find_or_create_by!(phone_number:phone_params[:phone_number])do|u|
            u.password=SecureRandom.hex(15)
            u.name=phone_params[:name]
            u.country_code="62"
        end
        if user.verified!=true
            send_otp_wa(user)
        end
    end

    def verify_phone
        code=VerificationCode.verify(verify_params[:user_id],verify_params[:code])
        user=User.find_by(id:verify_params[:user_id],verified:nil)
        if code && user
            if code.expire_at.to_i>Time.now.to_i
                updated=user.update(verified: true)
            else
                render json: {errors:{message:"Code already expired"}}, status: :bad_request
            end
        end
        if updated 
            render json: {data:{message:"Account successfully verified"}}, status: :ok 
        end
        if !code
            render json: {errors:{message:"Invalid code"}}, status: :bad_request
        end
        if !user && User.find_by(id:verify_params[:user_id])
            render json: {errors:{message:"Phone already registered"}}, status: :bad_request
        end        
    end

    def create_password
        user=User.find_by(id:create_password_params[:user_id])
        if user
            updated=user.update(password: create_password_params[:password])
        else
            render json: {errors:{message:"Invalid user id"}}, status: :bad_request
        end

        if updated
            render json: {data:{message:"Password successfully created"}}, status: :ok 
        end
    end

    
    
    def emailauth
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password]) 
          token = AuthenticationTokenService.encode(payload(user))
          render json: { token: token}, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end
    
    private

    def login_params
        params.require(:user).permit(:phone_number,:password)
    end
    def phone_params
        params.require(:user).permit(:name,:phone_number)
    end
    def email_param
        params.permit(:email, :password)
    end
    def create_password_params
        params.require(:user).permit(:user_id,:password)
    end
    def verify_params
        params.require(:user).permit(:user_id, :code)
    end
    def payload(user)
        {
            'phone':user.email,
            'name':user.name,
            'iat':Time.now.to_i
        }
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
        render json: message_sent
    end
end
