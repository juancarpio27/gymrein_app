class Admin::UserReservationsController < AdminController
  before_action :authenticate
  before_action :load_user

  def index
    @reservations = @user.reservations.joins(:class_date).order('class_dates.date DESC').paginate(:page => params[:page])
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end
end
