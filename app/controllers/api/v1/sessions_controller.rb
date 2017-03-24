class Api::V1::SessionsController < Api::ApiController

  # POST /api/v1/sessions/plain
  def plain
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      session = user.sessions.build(platform: params[:platform])
      session.create_api_key(user: user)
      render json: {success: true, user: user.as_json(user.class::Json::SHOW) }
    else
      render json: {success: false}
    end
  end

  def destroy
    session = @api_key.user.sessions.active.last
    if session.delete!
      {success: true}
    else
      {success: false}
    end
  end


end
