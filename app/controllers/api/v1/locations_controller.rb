class Api::V1::LocationsController < Api::ApiController
  
  def show
    @location = Location.find(params[:id])
    render json: @location.as_json
  end

  def index
    @locations = Location.all
    render json: @locations.as_json
  end

end
