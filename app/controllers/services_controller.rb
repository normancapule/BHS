class ServicesController < ApplicationController
  layout 'pages'

  def index
    respond_to do |format|
      format.json { render json: ServiceListDatatable.new(view_context)}
      format.html
    end
  end
  
  def add
    @service = Service.new
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def create
    @service = Service.new params[:service]
    if @service.save
      flash[:notification] = "Service has been created successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def edit 
    @service = Service.find(params[:id])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    @service = Service.find params[:id]
    @service.update_attributes params[:service]
    if @service.save
      flash[:notification] = "Service has been updated successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def destroy
    if Service.delete params[:id]
      flash[:notification] = "Service has been successfully deleted";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end
end
