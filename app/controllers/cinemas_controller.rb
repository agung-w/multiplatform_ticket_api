class CinemasController < ApplicationController
  before_action :set_cinema, only: %i[ show update destroy ]

  # GET /cinemas
  def index
    @cinemas = Cinema.all

    render json: @cinemas
  end

  # GET /cinemas/1
  def show
    render json: @cinema
  end

  # POST /cinemas
  def create
    @cinema = Cinema.new(cinema_params)

    if @cinema.save
      render json: @cinema, status: :created, location: @cinema
    else
      render json: @cinema.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cinemas/1
  def update
    if @cinema.update(cinema_params)
      render json: @cinema
    else
      render json: @cinema.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cinemas/1
  def destroy
    @cinema.destroy
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
