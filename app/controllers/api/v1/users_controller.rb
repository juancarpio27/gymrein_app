class Api::V1::UsersController < Api::ApiController

  before_action :assert_user, only: [:update]

  #POST /api/v1/users
  def create
    @user = User.new(user_params)
    @user.avatar = params[:avatar]
    if @user.save
      session = @user.sessions.build(platform: params[:platform])
      session.create_api_key(user: @user)
      render json: @user.as_json(@user.class::Json::SHOW)
    else
      render json: {errors: @user.errors.full_messages }, status: 422
    end
  end

  #PATCH /api/v1/users
  def update
    if @api_key.user.update(user_params)
      render json: @user.as_json(@user.class::Json::SHOW)
    else
      render json: {errors: @user.errors.full_messages }, status: 422
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation, :phone, :avatar, :birth, :sex)
  end

end
