class ReportsController < ApplicationController
  layout 'pages'
  
  before_filter :get_initializer_data

  def index

  end

  def performance
    get_initializer_data
    respond_to do |format|
      format.json { render json: ReportPerformanceDatatable.new(view_context)}
      format.html
    end
  end

  def refresh_performance
    get_initializer_data
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def financials
    respond_to do |format|
      format.json { render json: ReportFinancialDatatable.new(view_context)}
      format.html
    end
  end
  
  def refresh_financials
    recompute_financials
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update_financials
    DataStream.find(params[:id]).update_attributes expenses: params[:value].to_f
    render :text => params[:value]
  end

  private
  
  def recompute_financials
    t = Transaction.scoped
    t.pluck(:transac_date).uniq.each do |date|
      scope = t.of_date(date)
      stream = DataStream.find_or_create_by_stream_date(date)
      stream.update_attributes client_count: scope.count, gross: scope.pluck(:total_price).inject(&:+)
      stream.update_attributes net: (stream.gross.to_f - stream.expenses.to_f)
    end
  end

  def get_initializer_data
    @date = params[:date].blank? ? Date.current.strftime("%B %d, %Y") : Date.parse(params[:date]).strftime("%B %d, %Y")
  end

end
