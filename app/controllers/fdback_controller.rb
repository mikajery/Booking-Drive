class FdbackController < ApplicationController
	layout "frontend"
  def new
    
  	@drive_feedback = DriveFeedback.new
  	@book = Book.find_by_id(params[:format])
  	@drive = Drive.find_by_id(@book.drive_id)
  end
  def create
    @drive_feedback = DriveFeedback.new
    @drive_feedback.user_id = current_user.id
    @drive_feedback.drive_id = params[:id]
    s = ( params[:price].to_f + params[:service].to_f + params[:environment].to_f + params[:star4].to_f + params[:star5].to_f ) / (5 - (13 - params.length.to_i))
    if s.nan?
      @drive_feedback.score = "0.00".to_f
    else
      @drive_feedback.score = s
    end
    @drive_feedback.feed_msg = params[:feed_msg]
    if @drive_feedback.save
      redirect_to :controller => "searches", :action => "index"
    else
      redirect_to :action => "new"
    end
  end
  def show
    
  end
end
