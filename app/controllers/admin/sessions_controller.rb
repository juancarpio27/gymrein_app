class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    user = Admin.authenticate(params[:username], params[:password])
    if user
      session[:admin_id] = user.id
      redirect_to admin_root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_root_url, :notice => "Logged out!"
  end


end
