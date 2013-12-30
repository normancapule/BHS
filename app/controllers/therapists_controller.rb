class TherapistsController < ApplicationController
  layout 'pages'

  def index
    respond_to do |format|
      format.json { render json: AccountListDatatable.new(view_context, "therapists")}
      format.html
    end
  end
  
  def add
    @therapist = Account.new_therapist
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def create
    @therapist = Account.new_therapist params[:account]
    if @therapist.save
      flash[:notification] = "Account has been created successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def edit 
    @therapist = Account.find(params[:id])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    @therapist = Account.find(params[:id])
    @therapist.update_attributes params[:account]
    if @therapist.save
      flash[:notification] = "Account has been updated successfully";
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
