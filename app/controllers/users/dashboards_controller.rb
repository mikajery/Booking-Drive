class Users::DashboardsController < Users::BaseController
  before_filter :authenticate_user! 
  def index
    @drive = Drive.new 
    @user  = current_user
    @active_page = :panel_overview
  end

  def update_user
    @user  = current_user.assign_attributes(user_params)
    if @user.save
      
    else
      @active_page = :panel_edit_account
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_type, :type) 
  end
end
