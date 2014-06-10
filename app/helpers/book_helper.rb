module BookHelper
  def get_drive_way(str)
    DriveWay.where(drive_id: str).collect {|dw| [ dw.name, dw.id ] }
  end
end
