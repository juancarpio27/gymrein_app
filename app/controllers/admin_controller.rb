class AdminController < ActionController::Base

  layout 'admin'

  helper_method :current_user
  helper_method :logged_in?

  private

  def current_user
    @current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def authenticate
    logged_in? || access_denied
  end

  def logged_in?
    current_user.is_a? Admin
  end

  def access_denied
    redirect_to new_admin_session_path
  end


end