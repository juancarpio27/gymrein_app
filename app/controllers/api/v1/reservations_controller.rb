class Api::V1::ReservationsController < Api::ApiController

  before_action :assert_user

  def find_by_date
    date = Date.parse(params[:date])
    @reservations = @api_key.user.reservations.joins(:class_date).where(class_dates: {date: date.midnight..date.end_of_day})
    render json: @reservations.as_json(methods: [:class_date_name, :class_date_logo, :class_date])
  end

end
