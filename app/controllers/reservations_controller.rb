class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def index
    if params[:past]
      @reservations = current_user.reservations.joins(:class_date).where('class_dates.date <= ?',Time.now.in_time_zone('Mexico City')).order('class_dates.date DESC')
    else
      @reservations = current_user.reservations.joins(:class_date).where('class_dates.date > ?',Time.now.in_time_zone('Mexico City')).order('class_dates.date')
    end

  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

end
