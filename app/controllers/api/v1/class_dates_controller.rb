class Api::V1::ClassDatesController < Api::ApiController

  #GET api/v1/class_dates/:id
  def show
    @class = ClassDate.find(params[:id])
    render json: @class.as_json(ClassDate::Json::SHOW)
  end

  #POST api/v1/class_dates/find_by_date
  def find_by_date
    date = Date.parse(params[:date])
    @classes = ClassDate.where(date: date.midnight..date.end_of_day)
    render json: @classes.as_json(ClassDate::Json::LIST)
  end

  #POST api/v1/class_dates/find_by_location
  def find_by_location
    date = Date.today
    @classes = ClassDate.where(location_id: params[:location_id]).where(date: date.midnight..date.end_of_day)
    render json: @classes.as_json(ClassDate::Json::LIST)
  end

  #GET api/v1/class_dates/:id/get_reservations
  def get_reservations
    @class_date = ClassDate.find(params[:id])
    render json: @class_date.as_json(ClassDate::Json::MONITOR)
  end

end
