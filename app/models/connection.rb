class Connection < ActiveRecord::Base
  belongs_to :landlord
  belongs_to :tenant


  validates :tenant_email, presence: true
end
