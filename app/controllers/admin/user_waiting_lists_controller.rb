class Admin::UserWaitingListsController < AdminController
  before_action :authenticate
  before_action :load_user

  def index
    @waiting_lists = @user.waiting_lists.joins(:class_date).where('class_dates.date > ?',Time.now - 6.hours).order('class_dates.date DESC').paginate(:page => params[:page])
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end
end
