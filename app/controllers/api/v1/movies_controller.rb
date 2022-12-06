module Api
  module V1
    class MoviesController < ApplicationController
      # before_action :authorize_request
      def index
        @movies = Movie.all
        render json: {data:@movies}, status: :ok
      end
      def scrape
          url = 'https://jadwalnonton.com/now-playing/in-bandung/?city=12&page=1'
          response = MovieSpider.process(url)
          if response[:status] == :completed && response[:error].nil?
            render json: response
          else
            render json: "failed"
          end
        rescue StandardError => e
          render json: "Error: #{e}"
      end
      
    end
  end
end
    
