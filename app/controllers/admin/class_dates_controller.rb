class Admin::ClassDatesController < AdminController
  before_action :authenticate
  before_action :load_event

  def new
    @class_date = ClassDate.new
  end

  def index
    @class_dates = @event.class_dates
    if params[:beginning] and params[:beginning].length > 0
      @class_dates = @class_dates.where('date >= ?',Date.parse(params[:beginning]))
    end
    if params[:end] and params[:end].length > 0
      @class_dates = @class_dates.where('date <= ?',Date.parse(params[:end]))
    end
    @class_dates = @class_dates.order('date DESC').paginate(:page => params[:page])
  end

  def show
    @class_date = @event.class_dates.find(params[:id])
  end

  def create
    if params[:class_date][:repeat].blank?
      @class_date = @event.class_dates.build(class_date_params)
      if @class_date.save
        redirect_to admin_event_class_dates_path(@event)
      else
        redirect_to new_admin_event_class_dates_path(@event)
      end
    else
      type = params[:class_date][:repeat_type].to_i
      classes = params[:class_date][:repeat].to_i - 1
      date = DateTime.parse(params[:class_date][:date])
      location_id = params[:class_date][:location_id]
      instructor_id = params[:class_date][:instructor_id]
      limit = params[:class_date][:limit]
      room = params[:class_date][:room]
      duration = params[:class_date][:duration]
      for i in 0..classes
        @event.class_dates.create(date: date, location_id: location_id,instructor_id: instructor_id, limit: limit,room: room, duration: duration)
        if type == 1
          date = date + 1.day
        elsif type == 2
          date = date + 1.week
        elsif type == 3
          date = date + 1.month
        end
      end
      redirect_to admin_event_class_dates_path(@event)
    end

  end

  protected

  def load_event
    @event = Event.find(params[:event_id])
  end

  def class_date_params
    params.require(:class_date).permit(:date, :duration, :room, :location_id, :instructor_id, :limit)
  end

end
