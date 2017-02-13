class Api::V1::CardsController < Api::ApiController

  before_action :assert_user

  #GET /api/v1/cards
  def index
    @cards = @api_key.user.cards
    render json: @cards.as_json
  end

  #POST /api/v1/cards
  def create
    @card = @api_key.user.cards.create(card_params)
    if @card.save
      render json: @card.as_json
    else
      render json: {errors: @card.errors.full_messages }, status: 422
    end
  end

  #DELETE /api/v1/cards/:id
  def destroy
    @card =  @api_key.user.cards.find(params[:id])
    if @card.destroy
      render json: @card.as_josn
    else
      redner json: {errors: "Not possible to remove card"},statud: 417
    end
  end

  protected

  def card_params
    params.require(:card).permit(:holder_name, :number, :expiration_month, :expiration_year, :brand)
  end

end
