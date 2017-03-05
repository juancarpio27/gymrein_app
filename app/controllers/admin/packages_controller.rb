class Admin::PackagesController < AdminController

  before_action :authenticate

  def index
    @packages = Package.paginate(:page => params[:page])
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      redirect_to admin_packages_path
    else
      redirect_to new_admin_package_path
    end
  end

  def show
    @package = Package.find(params[:id])
  end

  def edit
    @package = Package.find(params[:id])
  end

  def update
    @package = Package.find(params[:id])
    if @package.update(package_params)
      redirect_to admin_packages_path
    else
      redirect_to edit_admin_package_path
    end
  end

  def destroy
    @package = Package.find(params[:id])
    if @package.destroy
      redirect_to admin_packages_path
    else
      redirect_to admin_packages_path
    end
  end

  protected

  def package_params
    params.require(:package).permit(:name,:price,:classes)
  end

end
