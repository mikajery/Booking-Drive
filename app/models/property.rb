class Property < ActiveRecord::Base
  belongs_to :landlord
  belongs_to :tenant
end
