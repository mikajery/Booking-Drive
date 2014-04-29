class Users::DrivesController < ApplicationController
  layout "users/dashboards"
  def index
    @drives = Drive.all
  end

  def show
    @drive  = Drive.find params[:id]
  end

  def new
    @drive = Drive.new
  end

  def create
    @drive = Drive.create(drive_params)
    @drive.save!
    redirect_to controller: :drives, action: :index
  end

  def edit
    @drive  = Drive.find params[:id]
  end

  def update
    @drive.find 
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
:notes)
    end
end
