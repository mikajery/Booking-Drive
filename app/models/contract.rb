# == Schema Information
#
# Table name: contracts
#
#  id            :integer          not null, primary key
#  start_date    :date
#  end_date      :date
#  tenant_id     :integer
#  landlord_id   :integer
#  property_id   :integer
#  rental_amount :decimal(, )
#  pay_date      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  active        :boolean
#  room_no       :string(255)
#  notes         :text
#

class Contract < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :landlord
  belongs_to :property
end
