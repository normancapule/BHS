class PackageListDatatable
  include CommonMethods

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: packages.count,
      iTotalDisplayRecords: packages.total_entries,
      aaData: data
    }
  end

private
  def data
   packages.map do |s|
     {
       "0" => h(s.name),
       "1" => h(s.regular_price),
       "2" => h(s.formatted_services),
       "3" => "<a class='btn btn-small edit-btn' s_id='#{s.id}'><i class='icon-pencil'></i></a>"+
              "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this package?' s_id='#{s.id}'>"+
              "<i class='icon-trash'></i></a>"
     }
   end 
  end  

  def packages
    @packages ||= fetch_packages
  end

  def fetch_packages
    packages = Service.packages
    if params[:sSearch].present?
      packages = packages.where(['name LIKE :search',
                                  search: "%#{params[:sSearch]}%"])
    end
    if sort_column and sort_direction
      packages = packages.order("#{sort_column} #{sort_direction}")
    end
    packages.page(page).per_page(per_page)
  end

  def sort_column
    columns = %w[name regular_price] 
    columns[params[:iSortCol_0].to_i]=="nil" ? nil : columns[params[:iSortCol_0].to_i]
  end
end
