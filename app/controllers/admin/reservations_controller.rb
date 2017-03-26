class Admin::ReservationsController < AdminController
  before_action :authenticate
  before_action :load_class_date

  def index
    @reservations = @class_date.reservations.paginate(:page => params[:page])
  end

  protected

  def load_class_date
    @class_date = ClassDate.find(params[:class_date_id])
  end


end
