module Api
  module V1
    class TransactionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request

      # GET /transactions/1
      def show
        @transaction = Transaction.where(user_id:@current_user).order('transactions.created_at desc')
        render json: {data:{transactions: @transaction}}
      end



      private
        # Use callbacks to share common setup or constraints between actions.

      # Only allow a list of trusted parameters through.
      def transaction_params
        params.require(:transaction).permit(:order_id, :user_id, :type, :total, :status)
      end
    end
  end
end
