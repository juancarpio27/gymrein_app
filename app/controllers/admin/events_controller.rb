class Admin::EventsController < AdminController
  before_action :authenticate

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path
    else
      redirect_to new_admin_event_path
    end
  end

  def index
    @events = Event.paginate(:page => params[:page])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to admin_events_path
    else
      redirect_to edit_admin_event_path(@event)
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to admin_events_path
    else
      redirect_to admin_events_path
    end
  end

  protected

  def event_params
    params.require(:event).permit(:name, :description, :logo)
  end

end
