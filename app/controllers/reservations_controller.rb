class ReservationsController < ApplicationController
  layout 'pages'
  before_filter :authenticate_user!
  
  def index
    @reservation = Reservation.new :datetime => DateTime.current
    get_initializer_data
    respond_to do |format|
      format.json { render json: ReservationsDatatable.new(view_context)}
      format.html
    end
  end

  def refresh_main_table
    get_initializer_data
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def create
    date = Date.parse(params[:add_date])
    @new_reservation = Reservation.new :datetime => DateTime.current
    @reservation = Reservation.new params[:reservation]
    am_pm_checker
    @reservation.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0,
                                                    :year => date.year, :month => date.month, :day => date.day
    if @reservation.save
      flash[:notification] = "Reservation has been created successfully";
      params[:date] = @reservation.datetime.to_date.to_s
    end
    get_initializer_data
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def edit 
    @reservation = Reservation.find params[:id]
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    date = Date.parse(params[:edit_date])
    update_reservation = Reservation.find params[:id]
    am_pm_checker
    update_reservation.datetime = DateTime.current.change :hour => params[:hour].to_i, :min => params[:minutes].to_i, :sec => 0,
                                                          :year => date.year, :month => date.month, :day => date.day
    if update_reservation.update_attributes params[:reservation]
      flash[:notification] = "Reservation has been successfully updated";
      params[:date] = update_reservation.datetime.to_date.to_s
    end
    get_initializer_data
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def destroy
    if Reservation.delete params[:id]
      flash[:notification] = "Reservation has been successfully deleted";
    end
    get_initializer_data
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  private
  def get_initializer_data
    @date = params[:date].blank? ? Date.current.strftime("%B %d, %Y") : Date.parse(params[:date]).strftime("%B %d, %Y")
    @reservations = Reservation.for_today(nil, nil, @date)
  end

  def am_pm_checker
    case params[:am_pm]
      when "AM"
        params[:hour] = 0 if params[:hour].to_i == 12
      when "PM"
        params[:hour] = params[:hour].to_i + 12 if params[:hour].to_i < 12
    end
  end
end
