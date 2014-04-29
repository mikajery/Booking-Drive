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


end 