class PagesController < ApplicationController
  layout 'pages'
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    @reservation = Reservation.new :datetime => DateTime.current
    respond_to do |format|
      format.json { render json: ReservationsDatatable.new(view_context)}
      format.html
    end
  end

  def create_reservation
    @new_reservation = Reservation.new :datetime => DateTime.current
    @reservation = Reservation.new params[:reservation]
    am_pm_checker
    @reservation.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0
    if @reservation.save
      flash[:notification] = "Reservation has been created successfully";
    end
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
    am_pm_checker
    update_reservation.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0
    if update_reservation.update_attributes params[:reservation]
      flash[:notification] = "Reservation has been successfully updated";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def delete_reservation
    if Reservation.delete params[:id]
      flash[:notification] = "Reservation has been successfully deleted";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  private
  def am_pm_checker
    case params[:am_pm]
      when "AM"
        params[:hour] = 0 if params[:hour].to_i == 12
      when "PM"
        params[:hour] = params[:hour].to_i + 12 if params[:hour].to_i < 12
    end
  end
end
