class ReportFinancialDatatable
  include CommonMethods
  require 'will_paginate/array'

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: streams.size,
      iTotalDisplayRecords: streams.total_entries,
      aaData: data
    }
  end

private
  def data
   streams.map do |s|
     {
       "0" => h(s.id),
       "1" => h(s.client_count.to_i),
       "2" => h(s.stream_date),
       "3" => h(s.gross.to_f),
       "4" => h(s.expenses.to_f),
       "5" => h(s.net.to_f)
     }
   end 
  end  
  
  def date
    params[:date].blank? ? Date.current.strftime("%B %d, %Y") : Date.parse(params[:date]).strftime("%B %d, %Y")
  end

  def streams
    streams = DataStream.scoped
    streams = streams.order("#{sort_column} #{sort_direction}")
    streams.page(page).per_page(per_page)
  end

  def sort_column
    columns = %w[id client_count stream_date gross expenses net]
    columns[params[:iSortCol_0].to_i]
  end
end
