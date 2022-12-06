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
end

