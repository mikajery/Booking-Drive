class Users::DrivesController < ApplicationController
  layout "users/dashboards"
  def index
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
                  :address_line_1,
                  :description,
                  :address_line_2,
                  :city_town,
                  :province_state_county_region,
                  :country,
                  :post_code,
                  :phone_number,
:notes)
    end
end
