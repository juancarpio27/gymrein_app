class Api::V1::WaitingListsController < Api::ApiController

  before_action :assert_user

  #POST /api/v1/waiting_lists
  def create
    @waiting_list = @api_key.user.waiting_lists.build(waiting_list_params)
    if @waiting_list.user.has_existing_class(@waiting_list.class_date.date,@waiting_list.class_date.duration)
      render json: {success: false, error: 'Already have a scheduled class'}
    elsif @waiting_list.user.available_classes == 0
      render json: {success: false, error: 'No available classes'}
    else
      if @waiting_list.save
        render json:{success: true, waiting_list: @waiting_list.as_json(WaitingList::Json::SHOW)}
      else
        render json: {success: false, errors: @waiting_list.errors.full_messages }, status: 422
      end
    end
  end

  #GET /api/v1/waiting_lists
  def index
    @waiting_lists = @api_key.user.waiting_lists
    render json: @waiting_lists.as_json(WaitingList::Json::LIST)
  end

  #GET /api/v1/waiting_lists/:id
  def show
    @waiting_list = @api_key.user.waiting_lists.find(params[:id])
    render json: @waiting_list.as_json(WaitingList::Json::SHOW)
  end

  #DELETE /api/v1/waiting_lists/:id
  def destroy
    @waiting_list = @api_key.user.waiting_lists.find(params[:id])
    if @waiting_list.destroy
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  #GET api/v1/wiaiting_lists/future
  def future
    @waiting_list = @api_key.user.waiting_lists.joins(:class_date).where('class_dates.date > ?',Time.now - 5.hours)
    render json: @waiting_list.as_json(WaitingList::Json::LIST)
  end

  protected

  def waiting_list_params
    params.require(:waiting_list).permit(:class_date_id)
  end

end
