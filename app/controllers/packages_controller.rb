class PackagesController < ApplicationController
  layout 'pages'
  
  def index
    respond_to do |format|
      format.json { render json: PackageListDatatable.new(view_context)}
      format.html
    end
  end
  
  def add
    @package = Service.new mytype: "package"
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def create
    @package = Service.new params[:service]
    if @package.save
      manage_services
      flash[:notification] = "Package has been created successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def edit 
    @package = Service.find(params[:id])
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def update
    @package = Service.find params[:id]
    @package.update_attributes params[:service]
    if @package.save
      manage_services
      flash[:notification] = "Package has been updated successfully";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  def destroy
    if Service.delete params[:id]
      flash[:notification] = "Package has been successfully deleted";
    end
    respond_to do |format|
      format.js {render :layout => false}
    end
  end

  private

  def manage_services
    @package.services.clear
    params[:selected_service].each do |s|
      @package.services << Service.find(s)
    end
  end
end
