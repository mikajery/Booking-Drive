class LandlordsController < ApplicationController
  
  def index
  end

  def update

    @landlord = getprofile
    
    if @landlord.update_attributes(profile_params)
	  flash[:notice] = 'Profile Updated'
	  redirect_to controller: 'backend', action: 'profile'
    else
	  flash[:notice] = 'Error Updating'
	  redirect_to controller: 'backend', action: 'profile'
    end

  end

end
