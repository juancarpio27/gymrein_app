class Admin::LocationsController < AdminController
  before_action :authenticate

  def index
    @locations = Location.paginate(:page => params[:page])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to admin_locations_path
    else
      redirect_to new_admin_location_path
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to admin_locations_path
    else
      redirect_to new_admin_location_path
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      redirect_to admin_locations_path
    else
      redirect_to admin_locations_path
    end
  end

  protected

  def location_params
    params.require(:location).permit(:name, :address, :opening_hour, :closing_hour)
  end

end
