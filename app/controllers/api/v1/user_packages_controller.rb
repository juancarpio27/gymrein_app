class Api::V1::UserPackagesController < Api::ApiController

  before_action :assert_user

  def create
    @user_package = @api_key.user.user_packages.build(package_id: params[:package_id], card_id: params[:card_id], promotion_id: params[:promotion_id])
    @user_package.price = @user_package.calculate_price
    if @user_package.save
      render json: @user_package.as_json
    else
      render json: {errors: @user_package.errors.full_messages }, status: 422
    end
  end

end
