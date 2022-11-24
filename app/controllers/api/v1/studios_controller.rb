module Api
  module V1
    class StudiosController < ApplicationController
      
      before_action :set_studio, only: %i[ show update destroy ]

      def studio_info
        render json: @studio
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
