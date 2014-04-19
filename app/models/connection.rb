# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  approved     :boolean
#  landlord_id  :integer
#  tenant_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#  tenant_email :string(255)
#

class Connection < ActiveRecord::Base
  belongs_to :landlord
  belongs_to :tenant


  validates :tenant_email, presence: true
end
