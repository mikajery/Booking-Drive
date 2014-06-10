class SearchesController < ApplicationController
  layout "frontend"
  
  def index
  	
    if !(params[:search].blank?)
      @drives = Drive.near([params[:search]], 50, :order => :distance)
    
    else
    
      @drives = Drive.all
    end
  end
end
