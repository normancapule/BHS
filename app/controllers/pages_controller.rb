class PagesController < ApplicationController
  layout 'pages'
  
  def index
    @reservation = Reservation.new :datetime => DateTime.current
    get_reservations
  end

  def show

  end
  
  def create_reservation
    @new_reservation = Reservation.new :datetime => DateTime.current
    @reservation = Reservation.new params[:reservation]
    params[:am_pm] == "AM" ? true : params[:hour] = params[:hour].to_i + 12
    @reservation.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0
    @reservation.save
    get_reservations
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def edit_reservation
    @reservation = Reservation.find params[:id]
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def update_reservation
    update_reservation = Reservation.find params[:reservation][:id]
    params[:am_pm] == "AM" ? true : params[:hour] = params[:hour].to_i + 12
    update_reservation.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0
    update_reservation.update_attributes params[:reservation]
    get_reservations
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def delete_reservation
    Reservation.delete params[:id]
    get_reservations
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  private
  def get_reservations
    @reservations = Reservation.for_today
  end
end
