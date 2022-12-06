module Api
  module V1
    class WalletsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request
      before_action :get_balance, only: %i[show_user_wallet]

      
      # GET /wallets/1
      def show_user_wallet
        wallet=Wallet.find_by(user_id:@current_user.id)
        if wallet
          render json: {data:{wallet: {balance:wallet.balance}}}
        else
          render json:{error:{status:422,message: "Wallet is not activated yet"}}, status: :unprocessable_entity
        end
      end


      def top_up
        if (top_up_params[:amount].to_i>0 && top_up_params[:amount].to_i<2000000)
          @wallet = Wallet.top_up(@current_user.id,top_up_params)
          if @wallet
            if !@wallet.errors
              render json: {data:{message:"Top up success",wallet: @wallet}}, status: :created
            else
              render json: {error:{status:422,message: @wallet}}, status: :unprocessable_entity
            end
          else
            render json:{error:{status:422,message: "Wallet is not activated yet"}}, status: :unprocessable_entity
          end
        else
          render json:{error:{status:422,message: "Invalid top up amount"}}, status: :unprocessable_entity
        end
      end

      def pay
        if (top_up_params[:amount].to_i>0)
          @wallet = Wallet.top_up(@current_user.id,top_up_params)
          if !@wallet.errors
            render json: {data:{message:"Top up success",wallet: @wallet}}, status: :created
          else
            render json: {error:{status:422,message: @wallet}}, status: :unprocessable_entity
          end
        else
          render json:{error:{status:422,message: "Invalid top up amount"}}, status: :unprocessable_entity
        end
      end


      def activate
        @wallet = Wallet.new(user_id:@current_user.id,balance:0)
        if @wallet.save
          render json: {data:{message:"Successfully activated",wallet:@wallet}}, status: :created
        else
          render json: {error:{status:422,message:@wallet.errors}}, status: :unprocessable_entity
        end
      end


      private
        # Use callbacks to share common setup or constraints between actions.
      def set_wallet
        @wallet = Wallet.find(params[:id])
      end

      def top_up_params
        params.require(:wallet).permit(:amount, :method)
      end

      def pay
        params.require(:wallet).permit(:amount, :payment_purpose)
      end

      def get_balance
        @user= User.find_by!(phone_number:@current_user[:phone_number])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: params }, status: :not_found
      end

      # Only allow a list of trusted parameters through.
      def wallet_params
        params.require(:wallet).permit(:user_id, :balance)
      end
    end
  end
end
