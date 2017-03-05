class Api::V1::PromotionsController < Api::ApiController

  before_action :assert_user

  #POST /api/v1/promotions/validate
  def validate
    @promotion = Promotion.find_by_code(params[:code])
    if @promotion
      render json: @promotion.as_json
    else
      render json: {errors: "Promotion not found."}
    end
  end

end
