class PagesDatatable < PagesController
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Reservation.for_today.count,
      iTotalDisplayRecords: reservations.total_entries,
      aaData: data
    }
  end

private

  def data
   reservations.map do |r|
     [
       h(r.name),
       h(r.number_people),
       h(r.formatted_time),
       "<a class='btn btn-small edit-btn' r_id='#{r.id}'><i class='icon-pencil'></i></a>"+
       "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this reservation?' r_id='#{r.id}'>"+
       "<i class='icon-trash'></i></a>"
     ]
   end 
  end  

  def reservations
    @reservations ||= fetch_reservations
  end

  def fetch_reservations
    reservations = Reservation.for_today(sort_column, sort_direction)
    reservations = reservations.page(page).per_page(per_page)
    if params[:sSearch].present?
      reservations = reservations.where("name like :search or number_people like :search", search: "%#params[:sSearch]%")
    end
    reservations
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end
  
  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name number_people datetime]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
