class Payment < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :landlord
  belongs_to :contract
  belongs_to :property


  def paypal_url(return_url)

    values = {
      # get it form your http://sandbox.paypal.com account
      :business => self.landlord.paypal_email_id,
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }
    # These values set up the details for the item on paypal.
       values.merge!({
        # The amount is in cents
        "amount_1" => self.amount,
        "item_name_1" => 'GenieLets Rent Invoice ID: ' + self.id.to_s,
        "item_number_1" => 'For Due Date: ' + self.due_date.to_s,
        "quantity_1" => 1,
        "currency_code" => self.landlord.currency.upcase
      })

    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query

  end

end
