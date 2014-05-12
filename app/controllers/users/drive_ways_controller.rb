class Users::DriveWaysController < Users::BaseController
  before_action :set_drive_way, only: [:show, :edit, :update, :destroy]

  def index
    @drive_ways = current_user.drive_ways
    @drive_way = DriveWay.new
  end

  def show
  end

  def new
    @drive_ways = current_user.drive_ways
    @drive_way = DriveWay.new
  end

  def edit
    @drive_way = DriveWay.find(params[:id])
  end

  def create
    @drive_way = DriveWay.new(drive_way_params)

    respond_to do |format|
      if @drive_way.save
        format.html { redirect_to controller: 'users/drive_ways', action: 'index', notice: 'Drive way was successfully created.' }
        format.json { render :show, status: :created, location: @drive_way }
      else
        format.html { render :new }
        format.json { render json: @drive_way.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @drive_way.update(drive_way_params)
        format.html { redirect_to controller: 'users/drive_ways', action: 'index', notice: 'Drive way was successfully updated.' }
        format.json { render :show, status: :ok, location: @drive_way }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    debugger
    @drive_way.destroy
    respond_to do |format|
      format.html { redirect_to drive_ways_url }
    end
  end

  private
    def set_drive_way
      @drive_way = DriveWay.find(params[:id])
    end

    def drive_way_params
      params.require(:drive_way).permit(:price, :name, :description, :size, drive_way_availabilities: [:from, :to, :inclussion], drive_way_prices: [:days, :price])
    end
end
