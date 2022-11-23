class ApplicationController < ActionController::Base
    include ActionController::HttpAuthentication::Token
    def not_found
        render json: { error: 'not_found' }
    end
    def authorize_request
        token,_options=token_and_options(request)
        decoded=AuthenticationTokenService.decode(token)
        @current_user=User.find(decoded['user_id'])
        rescue ActiveRecord::RecordNotFound,JWT::DecodeError
            render json:{ error: 'not_found' }, status: :unauthorized   
    end
end

