class SearchesController < ApplicationController
  layout "frontend"
  
  def index
  	
    if params[:search].present? 
      @drives = Drive.search(params[:search]).order("name_of_building ASC")
    else
    
      @drives = Drive.all
    end
  end
end
