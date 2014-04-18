class Contract < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :landlord
  belongs_to :property
end
