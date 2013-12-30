class TransactionsController < ApplicationController
  layout 'pages'
  before_filter :get_selection_requirements, :only => [:select_customer, :select_service_time]
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
    @transaction = Transaction.new params[:transaction].delete_if { |k, v| v.empty? }
    unless params[:services].blank?
      services = params[:services].map { |x| Service.find(x) }
      @transaction.services = services
    end
    if @transaction.save
      params[:date] = @transaction.transac_date.to_s
      initialize_main_table
      flash[:notification] = "Transaction successfully created."
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    @transaction.update_attributes params[:transaction]
    unless params[:services].blank?
      services = params[:services].map { |x| Service.find(x) }
      @transaction.services = services
    end
    if @transaction.save
      params[:date] = @transaction.transac_date.to_s
      initialize_main_table
      flash[:notification] = "Transaction successfully updated."
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def destroy
    Transaction.destroy(params[:id])
    initialize_main_table
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def show
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
  
  def paid
    @transaction = Transaction.find(params[:id])
    @transaction.paid = !params[:paid].blank?
    @transaction.save
    render :nothing => true
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
    @transaction.transaction_type = params[:am_pm]
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
      format.json { render json: AccountListDatatable.new(view_context, "transactions")}
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
  
  def get_selection_requirements
    @customer = Account.find(params[:id])
    @transaction = params[:transaction_id].blank? ? @customer.transactions.new : Transaction.find(params[:transaction_id])
  end

  def initialize_main_table
    params[:date] ? date = Date.parse(params[:date]) : date = Date.current
    @date = {:to_parse => date.strftime("%d-%m-%Y"), :format => date.strftime("%B %d, %Y")}
  end
end
