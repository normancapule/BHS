class TransactionsController < ApplicationController
  layout 'pages'
  before_filter :authenticate_user!

  def index
    process_date
    get_transaction_requirements
  end
  
  def refresh_main_table
    process_date
    get_transaction_requirements
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

  def main_table_data
    respond_to do |format|
      format.json { render json: TransactionsDatatable.new(view_context, params[:date])}
    end
  end
  
  def customer_table_data
    respond_to do |format|
      format.json { render json: CustomerListDatatable.new(view_context)}
    end
  end
  
  def select_customer
    @customer = Account.find(params[:id])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  private
  def get_transaction_requirements
    @transactions = Transaction.of_date(Date.parse(@date[:to_parse]))
    @transaction = Transaction.new
    @customers = Account.get_customers
    @therapists = Account.get_therapists
    @services = Service.order
  end

  def process_date
    params[:date] ? date = Date.parse(params[:date]) : date = Date.current
    @date = {:to_parse => date.strftime("%d-%m-%Y"), :format => date.strftime("%B %d, %Y")}
  end
end
