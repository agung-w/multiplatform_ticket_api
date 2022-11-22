class Authentication::AuthController < ApplicationController
    def omniauth
        user=User.from_omniauth(request.env['omniauth.auth'])
        if user.valid?
            render json: User.credentials.to_json
        else
            return json
        end
    end
end
