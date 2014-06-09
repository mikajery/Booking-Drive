class BookController < ApplicationController
  before_filter :authenticate_user!
  layout "frontend"
  def index
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

  def create
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

  def new
     if get_type != 'Landlord'
      redirect_to action: 'contracts_list'
    end 

    @payment = Payment.find(params[:id])

    if @payment.landlord_id != get_landlord.id 
      redirect_to action: 'contracts_list'
    end

    if request.request_method_symbol == :patch
     
      if @payment.update_attributes(payment_params)
        flash[:notice] = 'Payment Updated'
        if @payment.status == 'Unpaid'
          @payment.date_paid = nil
        end
        @payment.save

        redirect_to :controller => 'backend', :action => 'contract_view', :id => @payment.contract_id
      else
        flash[:notice] = 'Error'
      end

    end
    
  end

  def edit
    if get_type == "Tenant"
      redirect_to :controller => 'backend', :action => 'contract_view', :id => params[:id]
    end

      if get_type == "Landlord"

         @contract = Contract.new
         @tenants = Connection.where(landlord_id: get_landlord.id)
         @properties = Property.where(landlord_id: get_landlord.id)


         @contract = Contract.where(landlord_id: get_landlord.id, id: params[:id]).first

             if request.request_method_symbol == :patch
              @cont = Contract.find params[:id]
              if @cont.update_attributes(contract_params)
               
                @cont.landlord_id = get_landlord.id
                @cont.active = true
                @cont.save
                flash[:notice] = 'Contract Updated'
                redirect_to :controller => 'backend', :action => 'contract_view', :id => params[:id]

              else
                flash[:notice] = 'Error'
              end
            end

        @contracts = Contract.where(landlord_id: get_landlord.id)

      end
  end

  def delete
     @contract = Contract.find params[:id]

    Payment.delete_all(contract_id: @contract.id, landlord_id: get_landlord.id)

    @contract.delete

    flash[:notice] = 'Contract Deleted!'
    redirect_to action: 'contracts_list'
  end
end
