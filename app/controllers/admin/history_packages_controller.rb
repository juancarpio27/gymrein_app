class Admin::HistoryPackagesController < AdminController
  before_action :authenticate
  before_action :load_package

  def index
    @user_packages = @package.user_packages.order('created_at DESC').paginate(:page => params[:page])
  end

  protected

  def load_package
    @package = Package.find(params[:package_id])
  end
end
