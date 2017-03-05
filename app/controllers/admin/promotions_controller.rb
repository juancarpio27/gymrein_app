class Admin::PromotionsController < AdminController

  before_action :authenticate

  def index
    @promotions = Promotion.paginate(:page => params[:page])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to admin_promotions_path
    else
      redirect_to new_admin_promotion_path
    end
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to admin_promotions_path
    else
      redirect_to edit_admin_promotion_path
    end
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    if @promotion.destroy
      redirect_to admin_promotions_path
    else
      redirect_to admin_promotions_path
    end
  end

  protected

  def promotion_params
    params.require(:promotion).permit(:code, :promotion_type, :expiration, :amount)
  end

end
