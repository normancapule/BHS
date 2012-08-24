class PagesController < ApplicationController
  layout 'pages'

  def index
    @reservations = Reservation.for_today
  end

  def show

  end

end
