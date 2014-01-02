class ServiceListDatatable
  include CommonMethods

  def initialize(view)
    @view = view
    @customer = params[:id] ? Account.find(params[:id]) : nil
    @am_pm = params[:am_pm] ? params[:am_pm] : 1
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
   if @customer
     services.map do |s|
       {
         "0" => "<a class='btn btn-small add-service-btn' s_id='#{s.id}' s_name='#{s.name}'><i class='icon-plus'></i></a>",
         "1" => h(s.name),
         "2" => h(s.get_price(@am_pm, @customer))
       }
     end
   else
     services.map do |s|
       {
         "0" => h(s.name),
         "1" => h(s.service_type),
         "2" => h(s.regular_price),
         "3" => h(s.member_price_morn),
         "4" => h(s.member_price_eve),
         "5" => "<a class='btn btn-small edit-btn' s_id='#{s.id}'><i class='icon-pencil'></i></a>"+
                "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this service?' s_id='#{s.id}'>"+
                "<i class='icon-trash'></i></a>"
       }
     end
   end 
  end  

  def services
    @services ||= fetch_services
  end

  def fetch_services
    services = @customer ? Service.get_services(@customer) : Service.services
    if params[:sSearch].present?
      services = services.where(['name LIKE :search',
                                  search: "%#{params[:sSearch]}%"])
    end
    if sort_column == "price"
      sort_direction == "asc" ? services.sort! {|x| x.get_price(@am_pm, @customer)} : services.sort {|x| x.get_price(@am_pm, @customer)}.reverse!
    elsif sort_column and sort_direction
      services = services.order("#{sort_column} #{sort_direction}")
    end
    services.page(page).per_page(per_page)
  end

  def sort_column
    columns = @customer ? %w[nil name price] : %w[name service_type_id regular_price member_price_morn member_price_eve]
    columns[params[:iSortCol_0].to_i]=="nil" ? nil : columns[params[:iSortCol_0].to_i]
  end
end
