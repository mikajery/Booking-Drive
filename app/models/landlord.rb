# == Schema Information
#
# Table name: landlords
#
#  id                           :integer          not null, primary key
#  first_name                   :string(255)
#  middle_name                  :string(255)
#  last_name                    :string(255)
#  address_line_1               :string(255)
#  address_line_2               :string(255)
#  city_town                    :string(255)
#  province_state_county_region :string(255)
#  country                      :string(255)
#  primary_phone                :string(255)
#  secondary_phone              :string(255)
#  vat_number                   :string(255)
#  paypal_email_id              :string(255)
#  bank_account_no              :string(255)
#  bank_name                    :string(255)
#  bank_branch                  :string(255)
#  currency                     :string(255)
#  company_name                 :string(255)
#  company_description          :text
#  user_id                      :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#  subscription_id              :integer
#  subscription_type            :string(255)
#  avatar                       :string(255)
#

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    	record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Landlord < ActiveRecord::Base
  
  belongs_to :user
  has_many:subscription
  mount_uploader :avatar, AvatarUploader


end
