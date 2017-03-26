class Api::V1::ReservationsController < Api::ApiController

  before_action :assert_user

  #POST api/v1/reservations/find_by_date
  def find_by_date
    date = Date.parse(params[:date])
    @reservations = @api_key.user.reservations.joins(:class_date).where(class_dates: {date: date.midnight..date.end_of_day})
    render json: @reservations.as_json(Reservation::Json::LIST)
  end

  #GET api/v1/reservations/future
  def future
    @reservations = @api_key.user.reservations.joins(:class_date).where('class_dates.date > ?',Time.now.in_time_zone('Mexico City'))
    render json: @reservations.as_json(Reservation::Json::LIST)
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
    elsif @reservation.user.available_classes == 0
      render json: {success: false, error: 'No available classes'}
    else
      if @reservation.save
        @reservation.user.update_classes(-1)
        @reservation.class_date.new_class
        puts("NUMBER OF CLASSSESS!!!!!!")
        puts(@reservation.class_date.available)
        render json: {success: true, reservation: @reservation.as_json(Reservation::Json::SHOW)}
      else
        render json: {errors: @reservation.errors.full_messages }, status: 422
      end
    end
  end

  #DELETE /api/vi/reservations/:id
  def destroy
    @reservation = @api_key.user.reservations.find(params[:id])
    minutes = ((@reservation.class_date.date - Time.now.in_time_zone('Mexico City'))/60).to_i
    if minutes < 0
      render json: {success: false, error: 'Class is already done'}
    elsif minutes >= 0 and minutes < 90
      render json: {success: false, error: 'Can not cancel 90 minutes before class'}
    else
      if @reservation.destroy
        if @reservation.class_date.waiting_lists.count > 0
          waiting = @reservation.class_date.waiting_lists.order(:created_at).first
          @reservation.class_date.reservations.create(user: waiting.user)
          waiting.user.update_classes(-1)
          #TODO send notification to user
          waiting.destroy
        else
          @reservation.class_date.recover_class
        end
        render json: {success: true}
      else
        render json: {success: false, error: 'Something bad happened'}
      end
    end

  end

  protected

  def reservation_params
    params.require(:reservation).permit(:class_date_id)
  end

end
