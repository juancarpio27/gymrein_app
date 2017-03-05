class Api::V1::PackagesController < Api::ApiController

  before_action :assert_user

  #GET /api/v1/packages
  def index
    @packages = Package.all
    render json: @packages.as_json
  end

  #GET /api/v1/packages/:id
  def show
    @package = Package.find(params[:id])
    render json: @package.as_json
  end

end
