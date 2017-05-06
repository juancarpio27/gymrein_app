class Api::V1::UsersController < Api::ApiController

  before_action :assert_user, only: [:update, :show]

  #POST /api/v1/users
  def create
    @user = User.new(user_params)
    if params[:avatar]
      if params[:platform] == "ios"
        @user.avatar = params[:avatar]
      else
        base = StringIO.new(Base64.decode64(params[:avatar]))
        file = Paperclip.io_adapters.for(base)
        file.original_filename = "name_image"
        @user.avatar = file
      end
    end

    if @user.save
      session = @user.sessions.build(platform: params[:platform], device_id: params[:device_id])
      session.create_api_key(user: @user)
      render json: @user.as_json(@user.class::Json::SHOW)
    else
      render json: {errors: @user.errors.full_messages }, status: 422
    end
  end

  #PATCH /api/v1/users
  def update
    if params[:avatar]
      if @api_key.user.sessions.active.last.ios?
        @user.avatar = params[:avatar]
      else
        base = StringIO.new(Base64.decode64(params[:avatar]))
        file = Paperclip.io_adapters.for(base)
        file.original_filename = "name_image"
        @user.avatar = file
      end
    end

    if @api_key.user.update(user_params)
      render json: @user.as_json(@user.class::Json::SHOW)
    else
      render json: {errors: @user.errors.full_messages }, status: 422
    end
  end

  #POST /api/v1/users/validate
  def validate
    user = User.find_by_email(params[:email])
    if user.blank?
      render json: {exists: false}
    else
      render json: {exists: true}
    end
  end

  #POST /api/v1/users/send_password_recovery
  def send_password_recovery
    user = User.find_by_email(params[:email])
    if user
      user.send_reset_password_instructions
      render json: {success: true, message: 'Confirmation email sent'}
    else
      render json: {success: false, error: 'Mail does not exists'}
    end
  end

  #GET /api/v1/users/:id
  def show
    user = @api_key.user
    render json: @user.as_json(@user.class::Json::SHOW)
  end

  protected

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation, :phone, :avatar, :birth, :sex)
  end

end
