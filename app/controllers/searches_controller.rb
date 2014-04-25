class SearchesController < ApplicationController
  layout "frontend"
  
  def index
    if params[:search]
      @drives = Drive.near(params[:search], 50)
    else
      @drives = Drive.all
    end
  end
end
