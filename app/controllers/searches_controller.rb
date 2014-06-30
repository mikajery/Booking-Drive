class SearchesController < ApplicationController
  layout "frontend"
  
  def index
  	
    if params[:search].present? 
      @drives = Drive.search(params[:search]).order("created_at DESC")
    
    else
    
      @drives = Drive.all
    end
  end
end
