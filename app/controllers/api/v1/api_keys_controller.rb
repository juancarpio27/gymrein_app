class Api::V1::ApiKeysController < Api::ApiController

  before_action :assert_user

  #POST /api/v1/api_keys/validate
  def validate
    render json: {validate: true}
  end
  
end
