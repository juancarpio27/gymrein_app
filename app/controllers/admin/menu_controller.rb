class Admin::MenuController < Admin::AdminController
  before_action :authenticate
  def index
  end
end
