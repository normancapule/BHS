class CustomerListDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: customers.count,
      iTotalDisplayRecords: customers.total_entries,
      aaData: data
    }
  end

private

  def data
   customers.map do |c|
     {
       "0" => "<a class='btn btn-small add-customer-btn' c_id='#{c.id}' c_name='#{c.name}'><i class='icon-plus'></i></a>",
       "1" => h(c.firstname),
       "2" => h(c.lastname)
     }
   end 
  end  

  def customers
    @customers ||= fetch_customers
  end

  def fetch_customers
    customers = Account.get_customers
    customers = customers.page(page).per_page(per_page)
    if params[:sSearch].present?
      customers = customers.where(['firstname LIKE :search OR 
                                    lastname LIKE :search', 
                                    search: "%#{params[:sSearch]}%"])
    end
    customers.order("#{sort_column} #{sort_direction}")  
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end
  
  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[firstname firstname lastname]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
