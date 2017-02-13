class Api::V1::UsersController < Api::ApiController

  #POST /api/v1/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json
    else
      render json: {errors: @user.errors.full_messages }, status: 422
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation, :phone)
  end

end
