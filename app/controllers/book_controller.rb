class BookController < ApplicationController
  before_filter :authenticate_user!
  layout "frontend"
  def index
    @books = Book.all
  end

  def create
    
    @books = Book.new(book_params)
   # @books.update_attributes(params[:books])
    @books.status = true
    @books.user_id = current_user.id
    @books.drive_id = params[:drive_id]
    @books.drive_way_id = params[:DriveWay][:drive_way_id]
    
     
    if @books.save
      redirect_to :action => 'index'
    else
      redirect_to :action => 'new'
    end
    
  end

  def new
    
    @drive = Drive.find_by_id(params[:id])
    
    
    
  end

  def edit
  end

  def delete
  end
  
  private
  def book_params
    params.require(:books).permit(:username, :start_date, :end_date)
  end
end
