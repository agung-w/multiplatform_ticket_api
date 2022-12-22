module Api
  module V1
    class OrdersController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request

      

      def order_ticket 
        sub_total=order_params[:quantity]*Studio.find(order_params[:studio_id]).price
        platform_fee=sub_total/10
        @order = Order.new(
          user_id:@current_user.id,
          movie_id:order_params[:movie_id],
          studio_id:order_params[:studio_id],
          quantity:order_params[:quantity],
          sub_total:order_params[:quantity]*Studio.find(order_params[:studio_id]).price,
          platform_fee:platform_fee,
          schedule:order_params[:schedule],
          total:(sub_total+platform_fee),
          status:"UNPAID"
        )
        if @order.save
          seats.each do |seat|
            # kalau mau di tambah validasi
            Ticket.create(
              user_id:@current_user.id,
              order_id:@order.id,
              studio_id:order_params[:studio_id],
              movie_id:order_params[:movie_id],
              schedule:order_params[:schedule],
              seat:seat
            )
          end          
          render json: {data:{message:"Book Success",order:@order.as_json}}
        else
          render json: {error:{message:"Cant book at the moment",status:422}},status: :unprocessable_entity
        end
        
        
      end
      
      def cancel_order
        @order=Order.find_by(id:cancel_params)
        if @order&.status=="UNPAID"
          @ticket=Ticket.where(order_id:cancel_params,user_id:@current_user.id)
          if @ticket.destroy_all
            render json: {data:{message:"Cancel Success"}}
          else
            render json: {error:{message:"Cancelled failed",status:422}},status: :unprocessable_entity
          end
        elsif @order
          render json: {error:{message:"Order already paid",status:422}},status: :unprocessable_entity
        else
          render json: {error:{message:"Order is missing",status:422}},status: :unprocessable_entity
        end
        
      end

      def pay_ticket_order
        @order=Order.find_by(id:pay_params[:order_id],status:"UNPAID")
        if @order
          if (pay_params[:payment_method]=="WALLET")
            @wallet = Wallet.pay(@current_user.id,@order)
            if @wallet
              if @wallet.errors.size==0
                @order.update(status: 'PAID')
                render json: {data:{message:"Ticket successfully paid"}}, status: :created
              else
                render json: {error:{status:422,message: @wallet.errors}}, status: :unprocessable_entity
              end
            else
              render json:{error:{status:422,message: "Wallet is not activated yet"}}, status: :unprocessable_entity
            end
          else
            @pay=@order.pay(pay_params[:order_id],pay_params[:payment_method],pay_params[:method_fee])
            if @pay.errors.size==0
              render json: {data:{message:"Ticket successfully paid"}}, status: :created
            else
              render json: {error:{status:422,message: @pay.errors}}, status: :unprocessable_entity
            end
          end
        else
          render json:{error:{status:422,message: "Order already paid"}}, status: :unprocessable_entity
        end
      end


      def active_ticket
        @order=Order.where(user_id:@current_user.id,status:"PAID",schedule: date.midnight..date.end_of_day).order('orders.created_at desc')
        render json: {data:{tickets:@order.as_json}}
      end
      
      def all_ticket
        @order=Order.where(user_id:@current_user.id,status:"PAID").order('orders.created_at desc')
        render json: {data:{tickets:@order.as_json}}
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def pay_params
          params.require(:order).permit(:order_id,:payment_method,:method_fee)
        end

        def get_balance
          @wallet=Wallet.find_by(user_id:@current_user)
          unless @wallet
            render json: {error:{status:422,message:"Please activate your wallet"}}
          end
        end


        # Only allow a list of trusted parameters through.
        def order_params
          params.require(:order).permit(:movie_id, :studio_id, :quantity,:schedule)
        end

        def cancel_params
          params.require(:order_id)
        end
        def seats
          params.require(:seats)
        end
    end
  end
end
