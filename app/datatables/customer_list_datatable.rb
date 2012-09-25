class CustomerListDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view, type)
    @view = view
    @type = type
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
    case @type
      when "customers"
        customers.map do |c|
          {
            "0" => h(c.firstname),
            "1" => h(c.lastname),
            "2" => h(c.get_membership),
            "3" => "<a class='btn btn-small show-btn' c_id='#{c.id}'><i class='icon-eye-open'></i></a>"+
                   "<a class='btn btn-small edit-btn' c_id='#{c.id}'><i class='icon-pencil'></i></a>"+
                   "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this customer?' c_id='#{c.id}'>"+
                   "<i class='icon-trash'></i></a>"
          }
        end
      when "transactions"
        customers.map do |c|
          {
            "0" => h(c.firstname),
            "1" => h(c.lastname),
            "2" => "<a class='btn btn-small show-btn' c_id='#{c.id}'><i class='icon-eye-open'></i></a>"+
                   "<a class='btn btn-small edit-btn' c_id='#{c.id}'><i class='icon-pencil'></i></a>"+
                   "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this customer?' c_id='#{c.id}'>"+
                   "<i class='icon-trash'></i></a>"
          }
        end
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
