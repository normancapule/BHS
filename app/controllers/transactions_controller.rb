class TransactionsController < ApplicationController
  layout 'pages'
  before_filter :authenticate_user!
  before_filter :get_requirements, :only => [:select_customer, :select_service_time]
  before_filter :get_transaction_requirements, :only => [:initialize_transaction_modal]
  before_filter :initialize_main_table, :only => [:index, :refresh_main_table]
  
  def index
  end
  
  def refresh_main_table
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def create

  end

  def update

  end

  def destroy

  end
  
  def initialize_transaction_modal
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def select_customer
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def select_service_time
    @am_pm = params[:am_pm]
    @transaction.transaction_type = @am_pm.downcase == "am" ? 1 : 2
    respond_to do |format|
      format.js {render :layout => false}
    end
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
  
  def service_table_data
    respond_to do |format|
      format.json { render json: ServiceListDatatable.new(view_context)}
    end
  end
  
  private
  def get_transaction_requirements
    if params[:transaction_id]
      @transaction = Transaction.find(params[:transaction_id])
      @customer = @transaction.customer
      @therapist = @transaction.therapist
    else
      @transaction = Transaction.new
      @customer = Account.new_customer
      @therapist = Account.new_therapist
    end
    @customers = Account.get_customers
    @therapists = Account.get_therapists
    @services = Service.order
  end
  
  def get_requirements
    @customer = Account.find(params[:id])
    @transaction = params[:transaction_id].blank? ? @customer.transactions.new : Transaction.find(params[:transaction_id])
  end

  def initialize_main_table
    params[:date] ? date = Date.parse(params[:date]) : date = Date.current
    @date = {:to_parse => date.strftime("%d-%m-%Y"), :format => date.strftime("%B %d, %Y")}
    @transactions = Transaction.of_date(Date.parse(@date[:to_parse]))
  end
end
