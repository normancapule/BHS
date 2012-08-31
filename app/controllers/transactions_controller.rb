class TransactionsController < ApplicationController
  layout 'pages'

  def index
    params[:date] ? date = Date.parse(params[:date]) : date = Date.current
    @date = {:to_parse => date.strftime("%d-%m-%Y"), :format => date.strftime("%B %d, %Y")}
    @transaction = Transaction.new
    get_transactions

    respond_to do |format|
      format.json { render json: TransactionsDatatable.new(view_context, @date)}
      format.html
    end
  end
  
  def refresh_main_table
    params[:date] ? date = Date.parse(params[:date]) : date = Date.current
    @date = {:to_parse => date.strftime("%d-%m-%Y"), :format => date.strftime("%B %d, %Y")}
    @transaction = Transaction.new
    get_transactions
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def create

  end

  def edit 

  end

  def update

  end

  def destroy

  end

  private
  def get_transactions
    @transactions = Transaction.of_date(Date.parse(@date[:to_parse])).count
  end
  
end
