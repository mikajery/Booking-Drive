# == Schema Information
#
# Table name: subscription_payments
#
#  id                :integer          not null, primary key
#  subscription_type :string(255)
#  amount            :decimal(, )
#  date_from         :date
#  date_to           :decimal(, )
#  payment_for       :string(255)
#  payment_date      :date
#  created_at        :datetime
#  updated_at        :datetime
#  subscription_id   :integer
#

class SubscriptionPayment < ActiveRecord::Base
end
