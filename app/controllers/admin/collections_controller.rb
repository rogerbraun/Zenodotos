class Admin::CollectionsController < Admin::AdminController

  def index
    @page = params[:page] || 0
    @collections = Collection.page(@page) 
  end

end
