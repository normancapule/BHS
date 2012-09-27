class ServiceListDatatable
  include CommonMethods

  def initialize(view)
    @view = view
    @customer = Account.find(params[:id])
    @am_pm = params[:am_pm] ? params[:am_pm] : 1
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: services.count,
      iTotalDisplayRecords: services.size,
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
    if sort_column == "price"
      sort_direction == "asc" ? services.sort! {|x| x.get_price(@am_pm, @customer)} : services.sort {|x| x.get_price(@am_pm, @customer)}.reverse!
    elsif sort_column and sort_direction
      services.order("#{sort_column} #{sort_direction}")  
    end
    services
  end

  def sort_column
    columns = %w[nil name price]
    columns[params[:iSortCol_0].to_i]=="nil" ? nil : columns[params[:iSortCol_0].to_i]
  end
end
