class AccountListDatatable
  include CommonMethods

  def initialize(view, type)
    @view = view
    @type = type
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: accounts.count,
      iTotalDisplayRecords: accounts.total_entries,
      aaData: data
    }
  end

private
  def data
    case @type
      when "customers"
        accounts.map do |a|
          {
            "0" => h(a.firstname),
            "1" => h(a.lastname),
            "2" => h(a.nickname),
            "3" => h(a.get_membership),
            "4" => h(a.address),
            "5" => h(a.cellphone),
            "6" => h(a.birthday),
            "7" => "<a class='btn btn-small edit-btn' c_id='#{a.id}'><i class='icon-pencil'></i></a>"+
                   "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this customer?' c_id='#{a.id}'>"+
                   "<i class='icon-trash'></i></a>"
          }
        end
      when "transactions"
        accounts.map do |a|
          {
            "0" => "<a class='btn btn-small add-customer-btn' c_id='#{a.id}' c_name='#{a.name}'><i class='icon-plus'></i></a>",
            "1" => h(a.firstname),
            "2" => h(a.lastname)
          }
        end
      when "therapists"
        accounts.map do |a|
          {
            "0" => h(a.firstname),
            "1" => h(a.lastname),
            "2" => h(a.nickname),
            "3" => "<a class='btn btn-small edit-btn' c_id='#{a.id}'><i class='icon-pencil'></i></a>"+
                   "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this therapist?' c_id='#{a.id}'>"+
                   "<i class='icon-trash'></i></a>"
          }
        end
    end
  end  

  def accounts
    @accounts ||= fetch_accounts
  end

  def fetch_accounts
    case @type
      when "customers", "transactions" then accounts = Account.get_customers
      when "therapists" then accounts = Account.get_therapists
    end
    accounts = accounts.page(page).per_page(per_page)
    if params[:sSearch].present?
      accounts = accounts.where(['firstname LIKE :search OR 
                                  lastname LIKE :search OR
                                  nickname LIKE :search', 
                                  search: "%#{params[:sSearch]}%"])
    end
    sort_column ? accounts.order("#{sort_column} #{sort_direction}") : accounts
  end
  
  def sort_column
    columns = %w[firstname lastname]
    case @type
      when "transactions" then columns = %w[nil] + columns
      when "customers" then columns += %w[nickname nil nil cellphone]
      when "therapists" then columns = columns + %w[nickname]
    end
    columns += %w[nil]
    columns[params[:iSortCol_0].to_i]=="nil" ? nil : columns[params[:iSortCol_0].to_i]
  end
end
