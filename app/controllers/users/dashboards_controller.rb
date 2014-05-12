class Users::DashboardsController < Users::BaseController
  before_filter :authenticate_user! 
  def index
    @drive = Drive.new 
    @user  = current_user
    @active_page = :panel_overview
  end

  def update_user
    redirect_to users_dashboard_path

    @user  = current_user
    if @user.update_with_password(user_params)
      sign_in(current_user, :bypass => true)
      flash[:notice] = 'Profile updated.'
    else

    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_type, :type, :first_name, :last_name, :phone, :address1, :address2, :birthday, :gender, :zipcode, :city, :country, :confirm_password, :current_password, :picture) 
  end
end
