module Api
    module V1
        class UserController < ApplicationController
            before_action :set_user, only: %i[ user_info  ]

            def user_info
                render json: @user
            end

            private 
            def set_user
                @user = User.find(params[:id])
            end
        end
    end
end
