class ServiceListDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
    @customer = Account.find(params[:id])
    @am_pm = params[:am_pm] ? params[:am_pm].downcase : "am"
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: services.count,
      iTotalDisplayRecords: services.total_entries,
      aaData: data
    }
  end

private

  def data
   services.map do |s|
     {
       "0" => "<a class='btn btn-small add-service-btn' s_id='#{s.id}' s_name='#{s.name}'><i class='icon-plus'></i></a>",
       "1" => h(s.name),
       "2" => h(s.get_price(@am_pm, @customer))
     }
   end 
  end  

  def services
    @services ||= fetch_services
  end

  def fetch_services
    services = Service.get_services(@customer)
    services = services.page(page).per_page(per_page)
    if params[:sSearch].present?
      services = services.where(['name LIKE :search',
                                  search: "%#{params[:sSearch]}%"])
    end
    services.order("#{sort_column} #{sort_direction}")  
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end
  
  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name name name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
