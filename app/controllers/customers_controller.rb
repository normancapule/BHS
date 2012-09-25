class CustomersController < ApplicationController
  layout 'pages'
  before_filter :authenticate_user!

  def index
    @customer = Account.new_customer
    respond_to do |format|
      format.json { render json: CustomerListDatatable.new(view_context, "customers")}
      format.html
    end
  end
  
  def add
    @customer = Account.new_customer
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def create
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def edit 
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def destroy
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
end
