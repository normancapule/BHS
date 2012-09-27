module CommonMethods
  delegate :params, :h, :link_to, to: :@view
  
  private
  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
  
  def page
    params[:iDisplayStart].to_i/per_page + 1
  end
  
  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end
end
