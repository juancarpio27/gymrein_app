class Admin::LocationClassDatesController < AdminController
  before_action :authenticate
  before_action :load_location

  def index
    @class_dates = @location.class_dates.where('date > ?', Time.now - 6.hours).order('class_dates.date DESC').paginate(:page => params[:page])
  end

  protected

  def load_location
    @location= Location.find(params[:location_id])
  end
end
