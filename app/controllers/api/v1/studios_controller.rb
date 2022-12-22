module Api
  module V1
    class StudiosController < ApplicationController
      skip_before_action :verify_authenticity_token

      # before_action :authorize_request, except: %i[create index]
      before_action :set_studio, only: %i[ studio_info ]
      def studio_detail
        render json: {data:@studio}, status: :ok
      end

      def get_reserved_seat
        @reserved=Ticket.where(studio_id:reserved_seat_params[:id],schedule:reserved_seat_params[:date],movie_id:reserved_seat_params[:movie_id])
        render json: {data:{reserved_seats:@reserved}}
      end


      private
        # Use callbacks to share common setup or constraints between actions.
        def set_studio
          @studio = Studio.find(params[:id])
        end
        def reserved_seat_params
          params.require(:studio).permit(:id, :date,:movie_id)
        end
        # Only allow a list of trusted parameters through.
        def studio_params
          params.require(:studio).permit(:cinema_id, :code, :capacity)
        end
    end
  end
end
