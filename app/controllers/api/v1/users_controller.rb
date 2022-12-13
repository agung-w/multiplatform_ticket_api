module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request, except: %i[register_by_phone verify_phone create_password]
      before_action :find_user, only: %i[user_detail]

      # GET /users
      def index
        # @users = User.all
        # # render json: @users, status: :ok
      end

      # GET /users/{username}
      def user_detail
        render json: {data:@user}, status: :ok
      end

      def register_by_phone
        user=User.phone_registration(phone_params)
        if user.errors.size<=0
          if user.verified!=true
              send_otp_wa(user)
          else 
              render json: {error:{status: 400,message:"Phone already registered"}},status: :bad_request
          end
        else
          render json: {error:{status: 400,message:user.errors}},status: :bad_request
        end
      end

      def verify_phone
          code=VerificationCode.verify(verify_params[:phone_number],verify_params[:code])
          if code
              if code.expire_at.to_i>Time.now.to_i
                  render json: {data:{message:"Code verification success"}}
              else
                  render json: {error:{status: 400,message:"Code already expired"}},status: :bad_request
              end
          end
          if !code
              render json: {error:{status: 400,message:"Invalid code"}},status: :bad_request
          end       
      end

      def create_password
          user=User.find_by(phone_number:create_password_params[:phone_number])
          if user
              updated=user.update(verified: true,password: create_password_params[:password])
              token = AuthenticationTokenService.encode(payload(user))
          else
              render json: {error:{status: 400,message:"Invalid user id"}},status: :bad_request
          end

          if updated
              render json: {data:{message:"Password successfully created",token:token}}
          end
      end

      private
        def phone_params
          params.require(:user).permit(:name,:phone_number)
        end
        def create_password_params
            params.require(:user).permit(:phone_number,:password)
        end
        def verify_params
            params.require(:user).permit(:phone_number, :code)
        end

        def find_user
          @user= User.find_by!(phone_number:@current_user[:phone_number])
          rescue ActiveRecord::RecordNotFound
            render json: { errors: params }, status: :not_found
        end

        def user_params
          params.permit(:username,:phone,:email, :password)
        end
    end
  end
end
