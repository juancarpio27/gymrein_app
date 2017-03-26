class Admin::WaitingListsController < AdminController
  before_action :authenticate
  before_action :load_class_date

  def index
    @waiting_lists = @class_date.waiting_lists.order('created_at').paginate(:page => params[:page])
  end

  protected

  def load_class_date
    @class_date = ClassDate.find(params[:class_date_id])
  end

end
