class Api::V1::ClassDatesController < Api::ApiController

  before_action :assert_user

  #GET api/v1/class_dates/:id
  def show
    @class = ClassDate.find(params[:id])
    render json: @class.as_json(methods: [:event, :location, :instructor])
  end

  #POST api/v1/class_dates/find_by_date
  def find_by_date
    date = Date.parse(params[:date])
    @classes = ClassDate.where(date: date.midnight..date.end_of_day)
    render json: @classes.as_json(methods: [:event])
  end

end
