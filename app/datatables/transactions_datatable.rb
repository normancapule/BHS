class TransactionsDatatable < PagesController
  delegate :params, :h, :link_to, to: :@view

  def initialize(view, date)
    @view = view
    @date = Date.parse(date[:to_parse])
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Transaction.of_date(@date).count,
      iTotalDisplayRecords: transactions.total_entries,
      aaData: data
    }
  end

private

  def data
   transactions.map do |t|
     {
       "0" => h(t.customer.name),
       "1" => h(t.therapist.name),
       "2" => h(t.total_price),
       "3" => "<input type='checkbox' id='transaction_paid' value=#{t.paid} #{"checked" if t.paid} />",
       "4" => "<a class='btn btn-small display-btn' r_id='#{t.id}'><i class='icon-eye-open'></i></a>"+
              "<a class='btn btn-small edit-btn' r_id='#{t.id}'><i class='icon-pencil'></i></a>"+
              "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this transaction?' r_id='#{t.id}'>"+
              "<i class='icon-trash'></i></a>"
     }
   end 
  end  

  def transactions
    @transactions ||= fetch_transactions
  end

  def fetch_transactions
    transactions = Transaction.of_date(@date).custom_sort(sort_column, sort_direction)
    transactions = transactions.page(page).per_page(per_page)
    if params[:sSearch].present?
      transactions = transactions.where(['accounts.firstname LIKE :search OR 
                                          accounts.lastname LIKE :search', 
                                          search: "%#{params[:sSearch]}%"]).custom_sort(sort_column, sort_direction)
    end
    transactions
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end
  
  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[customer therapist total_price paid]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
