class Api::V1::EventsController < Api::ApiController

  before_action :assert_user

  def show
    @event = Event.find(params[:id])
    render json: @event.as_json(methods: [:logo_url])
  end

end
