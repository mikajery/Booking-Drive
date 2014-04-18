class Tenant < ActiveRecord::Base
  belongs_to :user
    mount_uploader :avatar, AvatarUploader

end
