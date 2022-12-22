module Api
  module V1
    class CinemasController < ApplicationController

      # GET /cinemas
      def index
        @cinemas = Cinema.all
        
        render json: {data:@cinemas.as_json}
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_cinema
          @cinema = Cinema.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def cinema_params
          params.require(:cinema).permit(:name, :location)
        end
    end
  end
end
