class RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, :only => [:create]


  def new
 		session[:type]    = params[:type]
    session[:package] = params[:package]
		super
  end

  def create
    super
    
    if resource.persisted?
      UserMailer.welcome_email(@user).deliver
    end
  end

  # def destroy
  #   super
  #   if resource.destroy
  #     UserMailer.close_email(@user).deliver
  #   end
  # end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
  end


end 