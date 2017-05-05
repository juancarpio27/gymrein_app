class Api::V1::LocationsController < Api::ApiController
  
  def show
    @location = Location.find(params[:id])
    render json: @location.as_json
  end

  def index
    @locations = Location.all
    render json: @locations.as_json
  end

  def find_classes
    date = Date.today
    @location = Location.find(params[:id]).class_dates.where(date: date.midnight..date.end_of_day)
    render json: @location.as_json(ClassDate::Json::LIST)
  end

end
