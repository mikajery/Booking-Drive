class PagesController < ApplicationController

  layout "frontend"

  def index
    @title = "Home"
  end

  def about
    @title = "About"
  end

  def pricing
    @title = "Pricing"
  end

  def helpcentre
    @title = "Help Centre"
  end

  def contactus
    @title = "Contact Us"
  end

  def features
    @title = "Features"
  end

  def download
    @title = "Download"
  end

  def testimonials
    @title = "Download"
  end




  def subscribe
    
    #Cancel operation if Tenant, Only Landlords have subscriptions
    if User.find_by_email(current_user.email).user_type == "Tenant"
         redirect_to controller: 'backend', action: 'dashboard'
         return
    end

    @title = "Subscribe"
    @profile = get_profile

    @sub = Subscription.find @profile.subscription_id


    #trial ok
    if @sub.subscription_type == "Trial" and @sub.date_to > Date.today
      redirect_to controller: 'backend', action: 'dashboard'
      return
    end

    #not trial but still valid
    if @sub.subscription_type != "Trial" and @sub.date_to > Date.today
      redirect_to controller: 'backend', action: 'dashboard'
      return
    end

    #if all preconditions failed, proceed to display subscribe page

    #get subscription type, if "Trial" create a new object, just display payment buttons, if just unpaid, redirect to process_subscription
    
    if @sub.payment_status == "Unpaid" and @sub.subscription_type != "Trial"

      redirect_to action: 'process_payment'
      return

    end

  end

  def process_subscription

    @profile = get_profile

    @subscription = Subscription.new
    @subscription.date_from = Date.today
    @subscription.date_to = Date.today + (1).months
    @subscription.save

    @profile.subscription_id = @subscription.id

    @profile.save
    @subscription.save

    @sub_type = ""

    if params[:id] == "1"
      @sub_type = "Standard"
    end  

    if params[:id] == "2"
      @sub_type = "Pro"
    end  

    if params[:id] == "3"
      @sub_type = "Enterprise"
    end


    @subscription.subscription_type = @sub_type
    @profile.subscription_type = @sub_type

    @profile.subscription_id = @subscription.id
    @subscription.landlord_id = @profile.id
    @subscription.payment_status = "Unpaid"

    @subscription.return_token = SecureRandom.urlsafe_base64(16)

    @subscription.save
    @profile.save


    redirect_to action: 'process_payment'
    return

  end

  def process_payment
    @title = "Process Payment"
    @profile = get_profile
    @sub = Subscription.find @profile.subscription_id

  end

  #return url after paypal payment
  def subscription_payment


    @sub = Subscription.where(return_token: params[:id]).first

    @amount = 0
    if @sub.subscription_type = "Standard"
      @amount = 3
    end
      
    if @sub.subscription_type = "Pro"
      @amount = 5
    end

    if @sub.subscription_type = "Enterprise"
      @amount = 10
    end

    @sub.payment_status = "Paid"
    @sub.save

    @sub_payment = SubscriptionPayment.new
    @sub_payment.subscription_type = @sub.subscription_type
    @sub_payment.amount = @amount
    @sub_payment.date_from = @sub.date_from
    @sub_payment.date_to   = @sub.date_to
    @sub_payment.payment_for = "Subscription"
    @sub_payment.subscription_id = @sub.id
    @sub_payment.payment_date = Date.today

    @sub_payment.save

    redirect_to :controller => 'backend', :action => 'dashboard'

  end

  def renew

    #Cancel operation if Tenant, Only Landlords have subscriptions
    if User.find_by_email(current_user.email).user_type == "Tenant"
         redirect_to controller: 'backend', action: 'dashboard'
         return
    end

  end

  #######
  def getuser

    return User.find_by_email(current_user.email)

  end
  
  def get_type

    session[:user_type] = User.find_by_email(current_user.email).user_type
    return session[:user_type]

  end

  def get_profile
    if get_type == "Tenant"
      redirect_to controller: 'backend', action: 'dashboard'
      return Tenant.find_by_user_id(getuser.id)

    end

    if get_type == "Landlord"
      return Landlord.find_by_user_id(getuser.id)
    end

    
  
  end  
  #######

end
