class Users::DrivesController < ApplicationController
  layout "users/dashboards"
  def index
    @drives = current_user.drives
    @drive  = Drive.new
  end

  def show
    @drive  = Drive.find params[:id]
  end

  def new
    @drive = Drive.new
  end

  def create
    @drive = current_user.drives.create(drive_params)
    redirect_to controller: :drives, action: :index
  end

  def edit
    @drive  = current_user.drives.find params[:id]
  end

  def update
    @drive =  current_user.drives.find params[:id]
    if @drive.update_attributes(drive_params)
      flash[:success] = 'Drive Successfuly Create'
      redirect_to controller: :drives, action: :index
    else
      render controller: :drives, action: :edit
    end
  end

  def destroy
    @drive = Drive.find params[:id]
    @drive.destroy
    redirect_to :index
  end

  private

    def drive_params
      params.require(:drive).permit(  :property_type,
                  :name_of_building,
                  :address,
                  :description,
                  :city,
                  :state,
                  :country,
                  :zip_code,
                  :phone_number,
                  :notes,
                  :phone, drive_ways_attributes: [ :name, :id, :price, :description, :created_at, :updated_at  ])
    end
end
