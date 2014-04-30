class Users::DriveWaysController < Users::BaseController
  before_action :set_users_drive_way, only: [:show, :edit, :update, :destroy]

  def index
    @users_drive_ways = DriveWay.all
  end

  def show
  end

  def new
    @users_drive_way = DriveWay.new
  end

  def edit
    @users_drive_way = DriveWay.find(params[:id])
  end

  def create
    @users_drive_way = DriveWay.new(users_drive_way_params)

    respond_to do |format|
      if @users_drive_way.save
        format.html { redirect_to controller: 'users/drive_ways', action: 'index', notice: 'Drive way was successfully created.' }
        format.json { render :show, status: :created, location: @users_drive_way }
      else
        format.html { render :new }
        format.json { render json: @users_drive_way.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @users_drive_way.update(users_drive_way_params)
        format.html { redirect_to controller: 'users/drive_ways', action: 'index', notice: 'Drive way was successfully updated.' }
        format.json { render :show, status: :ok, location: @users_drive_way }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    debugger
    @users_drive_way.destroy
    respond_to do |format|
      format.html { redirect_to users_drive_ways_url }
    end
  end

  private
    def set_users_drive_way
      @users_drive_way = DriveWay.find(params[:id])
    end

    def users_drive_way_params
      params.require(:drive_way).permit(:price, :name, :description)
    end
end
