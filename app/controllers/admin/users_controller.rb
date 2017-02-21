class Admin::UsersController < AdminController
  before_action :authenticate

  def index
    @users = User.paginate(:page => params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render new_admin_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation, :phone, :avatar)
  end

end
