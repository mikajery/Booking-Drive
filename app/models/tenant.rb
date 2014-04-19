# == Schema Information
#
# Table name: tenants
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  middle_name     :string(255)
#  last_name       :string(255)
#  sex             :string(255)
#  dob             :date
#  primary_email   :string(255)
#  secondary_email :string(255)
#  primary_phone   :string(255)
#  secondary_phone :string(255)
#  notes           :text
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  avatar          :string(255)
#

class Tenant < ActiveRecord::Base
  belongs_to :user
    mount_uploader :avatar, AvatarUploader

end
