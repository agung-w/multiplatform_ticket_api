class Authentication::AuthController < ApplicationController
    skip_before_action :verify_authenticity_token
    # def omniauth
    #     user=User.from_omniauth(request.env['omniauth.auth'])
    #     if user.valid?
    #         token = AuthenticationTokenService.encode(payload(user))
    #         render json: { token: token}, status: :ok
    #     else
    #         render json: { error: 'unauthorized' }, status: :unauthorized
    #     end
    # end

    def login_by_phone
        user=User.find_by(phone_number:login_params[:phone_number],verified:true)
        if user&.authenticate(login_params[:password]) 
            token = AuthenticationTokenService.encode(payload(user))
            render json: {data:{token: token} }
        else
            render json: {error:{status: 401, message: 'Invalid Credentials' }},status: :unauthorized
        end
    end

    

    
    
    # def emailauth
    #     @user = User.find_by_email(params[:email])
    #     if @user&.authenticate(params[:password]) 
    #       token = AuthenticationTokenService.encode(payload(user))
    #       render json: { token: token}, status: :ok
    #     else
    #       render json: { error: 'unauthorized' }, status: :unauthorized
    #     end
    #   end
    
    private

    def login_params
        params.require(:user).permit(:phone_number,:password)
    end

    def email_param
        params.permit(:email, :password)
    end

    
    
end
