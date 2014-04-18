class Subscription < ActiveRecord::Base
  belongs_to :landlord

  def paypal_url(return_url)

  	@amount = 0
  	if self.subscription_type = "Standard"
  		@amount = 3
  	end
  		
  	if self.subscription_type = "Pro"
  		@amount = 5
  	end

  	if self.subscription_type = "Enterprise"
  		@amount = 10
  	end


    values = {
      # get it form your http://sandbox.paypal.com account
      :business => 'ebay1@bluereliance.co.uk',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }
    # These values set up the details for the item on paypal.
       values.merge!({
        # The amount is in cents
        "amount_1" => @amount,
        "item_name_1" => 'GenieLets Subscription Invoice: ' + self.id.to_s,
        "item_number_1" => 'For Subscription: ' + self.date_from.to_s + ' to ' + self.date_to.to_s,
        "quantity_1" => 1,
        "currency_code" => "GBP"
      })

    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query

  end

end
