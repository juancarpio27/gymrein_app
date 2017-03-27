class Admin::UserPackagesController < AdminController
  before_action :authenticate
  before_action :load_user

  def index
    @user_packages = @user.user_packages.order('created_at DESC').paginate(:page => params[:page])
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end
end
