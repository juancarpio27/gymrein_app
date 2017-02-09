class Login::WithEmail

  def call
    success = false
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      session = user.sessions.build(platform: params[:platform])
      session.create_api_key(user: user)
      success = session.save
    end
    { success: success, models: {user: user} }
  end


end