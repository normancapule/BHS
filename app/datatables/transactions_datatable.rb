class TransactionsDatatable
  include CommonMethods

  def initialize(view, date)
    @view = view
    @date = Date.parse(date)
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: transactions.count,
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
       "3" => h(t.services.map(&:name).join(', ')),
       "4" => h(t.notes),
       "5" => "<input type='checkbox' class='paid-btn' value=#{t.paid} #{"checked" if t.paid} t_id=#{t.id}/>",
       "6" => "<a class='btn btn-small edit-btn' t_id='#{t.id}'><i class='icon-pencil'></i></a>"+
              "<a class='btn btn-small delete-btn' data-confirm='Are you sure you want to delete this transaction?' t_id='#{t.id}'>"+
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
  
  def sort_column
    columns = %w[customer therapist total_price nil nil paid nil]
    columns[params[:iSortCol_0].to_i]=="nil" ? nil : columns[params[:iSortCol_0].to_i]
  end
end
