class Users::DrivesController < ApplicationController
  layout "users/dashboards"
  def index
    @drives = Drive.all
  end

  def show
  end

  def new
    @drive = Drive.new
  end

  def create
    @drive = Drive.create(drive_params)
    @drive.save!
    redirect_to controller: :drives, action: :new
  end

  def edit
  end

  def update
  end

  def destroy
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
