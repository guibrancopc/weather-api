class Api::V1::LocationsController < ApiController
  before_action :set_location

  def show
    # render json: {
    #   id: @location.id,
    #   name: @location.name
    # }
    render json: @location, include: ['recordings']
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
