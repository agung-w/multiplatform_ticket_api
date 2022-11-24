module Api
  module V1
    class StudiosController < ApplicationController
      before_action :authorize_request, except: %i[create index]
      before_action :set_studio, only: %i[ studio_info ]

      def studio_detail
        render json: {data:@studio}, status: :ok
      end


      private
        # Use callbacks to share common setup or constraints between actions.
        def set_studio
          @studio = Studio.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def studio_params
          params.require(:studio).permit(:cinema_id, :code, :capacity)
        end
    end
  end
end
