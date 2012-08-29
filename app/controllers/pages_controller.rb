class PagesController < ApplicationController
  layout 'pages'

  def index
    @reservations = Reservation.for_today
    @reservation = Reservation.new :datetime => DateTime.current
    #@reservations = Reservation.
  end

  def show

  end
  
  def add_reservation
    @new_reserv = Reservation.new params[:reservation]
    params[:am_pm] == "AM" ? true : params[:hour] = params[:hour].to_i + 12
    @new_reserv.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0
    @new_reserv.save
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update_reservation
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def delete_reservation
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
end
