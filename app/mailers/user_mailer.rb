class UserMailer < ActionMailer::Base
  default from: "Developers@GenieBytes.com"
  def welcome_email(user)

  	@user = user
  	@url = "http://gl.bluereliance.co.uk/users/sign_in"
  	mail(to: @user.email, subject: "Welcome To Genielets")
  end
  
  def close_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Hope to see you again!")
  end
  def add_properties_email(user)
  end
end
