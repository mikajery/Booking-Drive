class BookController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_book, only: [:edit, :update, :delete, :show]
  layout "frontend"
  def index
    @books = Book.where(status: true)
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
  
  def update
    @book.status = true
    @book.user_id = current_user.id
    @book.drive_id = params[:drive_id]
    @book.drive_way_id = params[:DriveWay][:drive_way_id]
    if @book.update(book_params)
      redirect_to :action => 'index'
    else
      redirect_to :action => 'edit'
    end
  end
  
  def delete
    
    @book.status = false
    if @book.save
      redirect_to fdback_new_path(params[:id])
    else
      redirect_to :action => 'index'
    end
  end
  
  private
  def book_params
    params.require(:book).permit(:username, :start_date, :end_date)
  end
  
  def set_book
    @book = Book.find_by_id(params[:id])
  end
end
