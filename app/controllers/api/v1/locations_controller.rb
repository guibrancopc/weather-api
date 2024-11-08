class Api::V1::LocationsController < ApplicationController
  before_action :set_location

  def show
    # render json: {
    #   id: @location.id,
    #   name: @location.name
    # }
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
