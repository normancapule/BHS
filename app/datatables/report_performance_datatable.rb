class ReportPerformanceDatatable
  include CommonMethods
  require 'will_paginate/array'

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: therapists.size,
      iTotalDisplayRecords: therapists.total_entries,
      aaData: data
    }
  end

private
  def data
   therapists.map do |p|
     {
       "0" => h(p.name),
       "1" => h(p.push_transactions(date).count),
       "2" => h(p.package_transactions(date).count),
     }
   end 
  end  
  
  def date
    params[:date].blank? ? Date.current.strftime("%B %d, %Y") : Date.parse(params[:date]).strftime("%B %d, %Y")
  end

  def therapists
    therapists = Account.therapists
    case sort_column
    when "push"
      t = therapists.sort{|me| me.push_transaction.count}
      t.reverse! if sort_direction == "desc"
    when "package"
      t = therapists.sort{|me| me.package_transaction.count}
      t.reverse! if sort_direction == "desc"
    when "firstname"
      t = therapists.order("#{sort_column} #{sort_direction}")
    end
    t.paginate page: page, per_page: per_page
  end

  def sort_column
    columns = %w[firstname push package]
    columns[params[:iSortCol_0].to_i]
  end
end
