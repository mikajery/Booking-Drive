class Users::DashboardsController < Users::BaseController
  def index
    @drive = Drive.new    
  end

end
