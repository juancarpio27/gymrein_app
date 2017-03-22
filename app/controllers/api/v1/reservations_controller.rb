class Api::V1::ReservationsController < Api::ApiController

  before_action :assert_user

  #POST api/v1/reservations/find_by_date
  def find_by_date
    date = Date.parse(params[:date])
    @reservations = @api_key.user.reservations.joins(:class_date).where(class_dates: {date: date.midnight..date.end_of_day})
    render json: @reservations.as_json(methods: [:class_date_name, :class_date_logo, :class_date])
  end

  #POST /api/v1/reservations/:id/check_in
  def check_in
    @reservation = @api_key.user.reservations.find(params[:id])
    if @reservation.assisted
      render json: {success: 'Already checked in'}
    else
      @reservation.check_in
      render json: {success: true}
    end
  end

  #POST /api/v1/reservations
  def create
    @reservation = @api_key.user.reservations.build(reservation_params)
    if @reservation.class_date.available == 0
      render json: {success: false, error: 'Class is full'}
    elsif @reservation.user.has_existing_class(@reservation.class_date.date,@reservation.class_date.duration)
      render json: {success: false, error: 'Already have a scheduled class'}
    else
      if @reservation.save
        @reservation.class_date.new_class
        render json: {success: true, reservation: @reservation.as_json}
      else
        render json: {errors: @reservation.errors.full_messages }, status: 422
      end
    end
  end

  protected

  def reservation_params
    params.require(:reservation).permit(:class_date_id)
  end

end