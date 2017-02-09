class Api::ApiController < ActionController::Base

  def assert_user
    authenticate
    @user = @api_key.user if @api_key
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @api_key = ApiKey.find_by_access_token(token)
    end
  end


end