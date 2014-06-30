module BookHelper
  def get_drive_way(str)
    DriveWay.where(drive_id: str).collect {|dw| [ dw.name, dw.id ] }
  end
  
  def get_drive(drive_id)
    Drive.where(id: drive_id).collect {|dw| [ dw.name_of_building, dw.id ] }
  end
  
  def get_drive_way_id(drive_way_id)
    DriveWay.where(id: drive_way_id).collect {|dw| [ dw.name, dw.id ] }
  end
end
