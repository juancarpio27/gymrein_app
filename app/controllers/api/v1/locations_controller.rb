class Api::V1::LocationsController < Api::ApiController

  before_action :assert_user

  def show
    @location = Location.find(params[:id])
    render json: @location.as_json
  end

end
