class CustomersController < ApplicationController
  layout 'pages'
  before_filter :authenticate_user!

  def index
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
    account = params[:account]
    membership = {:member_type => account[:membership], :card_number => params[:card_number]}
    account.delete :membership
    @customer = Account.new_customer account, membership
    if @customer.save
      flash[:notification] = "Customer has been created successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def edit 
    @customer = Account.find(params[:id])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    account = params[:account]
    membership = {:member_type => account[:membership], :card_number => params[:card_number]}
    account.delete :membership
    @customer = Account.find(params[:id])
    @customer.update_attributes account
    case membership[:member_type].to_i
      when 0
        @customer.membership.delete if @customer.membership
      else
        @customer.membership ? @customer.membership.update_attributes(membership) : @customer.build_membership(membership)
    end
    if @customer.save
      flash[:notification] = "Customer has been updated successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def destroy
    if Account.delete params[:id]
      flash[:notification] = "Account has been successfully deleted";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
end
