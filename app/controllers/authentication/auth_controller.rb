class Authentication::AuthController < ApplicationController
    def omniauth
        user=User.from_omniauth(request.env['omniauth.auth'])
        if user.valid?
            token = AuthenticationTokenService.encode(payload(user))
            render json: { token: token}, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
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
    def email_param
        params.permit(:email, :password)
    end
    def payload(user)
        {
            'email':user.email,
            'user_id':user.id,
            'iat':Time.now.to_i
        }
    end
end
