class BackendController < ApplicationController
  before_filter :authenticate_user!
  layout "backend"

  def payment_confirm
    @payment = Payment.where(:return_token => params[:id]).first
    @payment.status = "Paid"
    @payment.payment_method = "Paypal"
    @payment.date_paid = Date.today
    @payment.save
    redirect_to :action => 'contract_view', :id => @payment.id
  end

  def index
  end

  def tenant_list
   @connections = Connection.where(landlord_id: get_landlord.id, approved: true) 
  end

  def tenant_view
   

   @a = Connection.where(landlord_id: get_landlord.id, tenant_id: params[:id], approved: true) 
  
   if @a.count == 0
     redirect_to action: 'display_404'
   else
     @tenant = Tenant.find params[:id] 
   end 


  end

  def contracts_list
    
      if get_type == "Landlord"
        @contracts = Contract.where(landlord_id: get_landlord.id, active:true)
      end

      if get_type == "Tenant"
        @contracts = Contract.where(tenant_id: get_tenant.id, active:true)
      end

  end

  def contract_edit
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


  def contract_view

      if get_type == "Landlord"
        
        @contract = Contract.where(landlord_id: get_landlord.id, id: params[:id]).first
        @payments = Payment.where(contract_id: @contract.id)
        @payments_late = Payment.all(:conditions => ["due_date <= ? AND status = ? AND contract_id = ?",Date.today, 'Unpaid', @contract.id])
      
      end

      if get_type == "Tenant"
        
        @contract = Contract.where(tenant_id: get_profile.id, active:true).first
        @payments = Payment.where(contract_id: @contract.id)
        @payments_late = Payment.all(:conditions => ["due_date <= ? AND status = ? AND contract_id = ?",Date.today, 'Unpaid', @contract.id])

      end

  end

  def contracts_inactive

      if get_type == "Landlord"
        @contracts = Contract.where(landlord_id: get_landlord.id, active: false)
      end

      if get_type == "Tenant"
        @contracts = Contract.where(tenant_id: get_tenant.id, active: false)
      end

  end
  
  def contract_delete


    @contract = Contract.find params[:id]

    Payment.delete_all(contract_id: @contract.id, landlord_id: get_landlord.id)

    @contract.delete

    flash[:notice] = 'Contract Deleted!'
    redirect_to action: 'contracts_list'

  end

  def payment_edit

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

  def payment_params
    params.require(:payment).permit(:tenant_id, :property_id, :landlord_id, :contract_id, :status, :due_date, :late_payment, :date_paid, :reference_no, :payment_method, :amount)
  end



  def mark_as_paid
    
    if get_type != 'Landlord'

      redirect_to :controller => 'backend', :action => 'contract_view', :id => @payment.contract.id

    end

    @payment = Payment.find params[:id]

    if @payment.landlord_id = get_landlord.id 
      @payment.status = 'Paid'
      @payment.date_paid = Date.today
      @payment.save
    end

    redirect_to :controller => 'backend', :action => 'contract_view', :id => @payment.contract.id

  end

  def contracts_add
   
   @contract = Contract.new
   @tenants = Connection.where(landlord_id: get_landlord.id)
   @properties = Property.where(landlord_id: get_landlord.id)
   if request.request_method_symbol == :post
     
      @cont = Contract.new

      if @cont.update_attributes(contract_params)
       
        @cont.landlord_id = get_landlord.id
        @cont.active = true

        @cont.save
        generate_payments(@cont)

        flash[:notice] = 'Contract Added'
        redirect_to :controller => 'backend', :action => 'contract_view', :id => @cont.id

      else

        flash[:notice] = 'Error'

      end

    end

    @contracts = Contract.where(landlord_id: get_landlord.id)

  end

  def generate_payments(contract)

    #(date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)

    num_of_months = (contract.end_date.year * 12 + contract.end_date.month) - (contract.start_date.year * 12 + contract.start_date.month)

    num_of_months.times do |n|
      
      calc_date = contract.start_date + (n + 1).months

      #get max days in the month, and use it if pay_date is greater than max days (e.g. 31, when in february there's only 28)
      days = Time.days_in_month(calc_date.month, calc_date.year)
      if contract.pay_date > days 
       calc_date = calc_date.change(day: days)
      else
        calc_date = calc_date.change(day: contract.pay_date)  
      end

      payment = Payment.new
      payment.tenant_id = contract.tenant.id
      payment.contract_id = contract.id
      payment.amount = contract.rental_amount
      payment.property_id = contract.property.id
      payment.landlord_id = contract.landlord.id
      payment.status = 'Unpaid'
      payment.due_date = calc_date
      payment.late_payment = false
      payment.date_paid = nil
      payment.return_token = SecureRandom.urlsafe_base64(16)

      payment.save

    end

  end

  def contract_params
    params.require(:contract).permit(:tenant_id, :property_id, :room_no, :rental_amount, :start_date, :end_date, :pay_date, :notes)
  end

  def add_tenant
    
   @connection = Connection.new

   if request.request_method_symbol == :post
      @conn = Connection.new
      if @conn.update_attributes(connection_params)
        flash[:notice] = 'Connection Request Added'
        @conn.landlord_id = get_landlord.id
        @conn.approved = false
        @conn.save
      else
        flash[:notice] = 'Error'

      end

   end

   @connections = Connection.where(landlord_id: get_landlord.id, approved: false) 

  end

  def connection_params
    params.require(:connection).permit(:tenant_email)
  end


  ####TENANT####
  def tenant_dashboard

    get_type

    @profile = get_profile

    #if no profile
    if !@profile 

      flash[:notice] = 'Please Enter Profile Data Before Continuing...'
      redirect_to action: 'tenant_profile'

    end
    
    
  end

  def tenant_profile

    @tenant = get_profile

    if request.request_method_symbol == :patch 
      if @tenant.update_attributes(tenant_profile_params)
        flash[:notice] = 'Profile Updated'
      else
      end
    end 

    if !@tenant
      @tenant = Tenant.new 
      @tenant.user_id = getuser.id
      @tenant.save
    end

  end


  def tenant_connection_requests
       @connections = Connection.where(tenant_email: current_user.email, approved: false) 

  end

  def active_connections
       @connections = Connection.where(tenant_email: current_user.email, approved: true) 
  end

 def approve_connection

       @conn = Connection.find params[:id]
       @conn.approved = true
       @conn.tenant_id = get_profile.id

       @conn.save

       flash[:notice] = 'You are now connected to ' + @conn.landlord.first_name.to_s + ' ' + @conn.landlord.last_name.to_s

       redirect_to action: 'active_connections'

  end

  def delete_connection

       @conn = Connection.find params[:id]
       @conn.delete

       flash[:notice] = 'Connection / Connection Request Deleted'

       if get_type == "Tenant"
        redirect_to action: 'active_connections'
       end
       
       if get_type == "Landlord"
        redirect_to action: 'add_tenant'
       end 


  end


  ####END TENANT#####
  def redirector

    if get_type == "Tenant"
      redirect_to action: 'tenant_dashboard'
      return
    end

    @profile = get_profile
    get_subscription_type

    if !@profile 

      flash[:notice] = 'Please Enter Profile Data Before Continuing...'
      redirect_to action: 'profile'

    end

    

  end

  def check
      if get_type == "Tenant"
        return 
      end
   
      if get_profile == nil 
        return
      end

      if get_profile.subscription_id == ""
        return
      end

      @sub = Subscription.find get_profile.subscription_id
      #trial expired
      if @sub.subscription_type == "Trial" and @sub.date_to < Date.today

        redirect_to controller: 'pages', action: 'subscribe'   

      end

      #subscription expired
      if @sub.subscription_type != "Trial" and @sub.date_to < Date.today

        redirect_to controller: 'pages', action: 'renew'   

      end 

      if @sub.payment_status == "Unpaid" 
        redirect_to controller: 'pages', action: 'process_payment'
      end


  end


  def dashboard

  	if get_type == "Tenant"
      redirect_to action: 'tenant_dashboard'
      return
    end

    @profile = get_profile
    get_subscription_type

    

    #if no profile
    if !@profile 

      flash[:notice] = 'Please Enter Profile Data Before Continuing...'
      redirect_to action: 'profile'

    end
    
  end

  def account_summary
    
    get_type
    @landlord = get_landlord

    
  end

  def profile
  	
  	get_type
  	
  	@landlord = get_landlord

    if request.request_method_symbol == :patch or request.request_method_symbol == :put
      if @landlord.update_attributes(profile_params)
        flash[:notice] = 'Profile Updated'
      else
        flash[:notice] = 'Profile Update Error'
      end
    end  


    if !@landlord

      @landlord = Landlord.new 
      @landlord.user_id = getuser.id
      @landlord.save

      sub_type = "Trial"

      @subscription = Subscription.new
      @subscription.subscription_type = sub_type
      @subscription.date_from = Date.today
      @subscription.date_to = Date.today + (1).months
      @subscription.save

      @landlord.subscription_id = @subscription.id
      @landlord.subscription_type = sub_type

      @landlord.save
      @subscription.landlord_id = @landlord.id
      @subscription.save

    end


  end

  def update_profile

    @landlord = get_landlord

  end

  #helpers
  #UTILITIES
  def get_profile
    
    if get_type == "Landlord"
      return Landlord.find_by_user_id(getuser.id)
    end

    if get_type == "Tenant"
      return Tenant.find_by_user_id(getuser.id)
    end
  
  end  

  def landlord_view
    @landlord = Landlord.find params[:id]
  end

  def getuser

    return User.find_by_email(current_user.email)

  end

  def get_landlord

    @l = Landlord.find_by_user_id(getuser.id)
    check
    return @l

  end

  def get_subscription_type
    
    if get_landlord == nil
      return
    end

    session[:subscription_type] = get_landlord.subscription_type 

  end      


  def get_tenant
    
    return Tenant.find_by_user_id(getuser.id)

  end

  def get_type

    session[:user_type] = User.find_by_email(current_user.email).user_type
    return session[:user_type]

  end

  def getproperties
   
    if get_type == "Landlord"
      logger.info"=============================#{get_landlord.id}"
      return Property.where(landlord_id: get_landlord.id)
    end
    if get_type == "Tenant"
      logger.info"=============================#{get_tenant.id}"
      return Property.where(tenant_id: get_tenant.id)
    end
  end

  def profile_params
    params.require(:landlord).permit(:avatar, :first_name, :middle_name, :last_name, :address_line_1, :address_line_2, :city_town, :province_state_county_region, :country, :primary_phone, :secondary_phone, :vat_number, :paypal_email_id, :bank_account_no, :bank_name, :bank_branch, :currency, :company_name, :company_description )
  end

  def tenant_profile_params
    params.require(:tenant).permit(:avatar, :first_name, :middle_name, :last_name, :sex, :dob, :primary_phone, :secondary_phone, :primary_email, :secondary_email, :notes)
  end

  def property_params
    params.require(:property).permit(:property_type, :number_of_rooms, :name_of_building, :address_line_1, :address_line_2, :city_town, :province_state_county_region, :country, :post_code, :phone_number, :approx_rental, :notes, :property_id)
  end

  def add_property
   
    if [:post, :patch].include?(request.request_method_symbol) 

      if request.request_method_symbol == :patch
         id = params[:property_id]
         @property = Property.find id

      else   
        
         @property = Property.new
         if get_type == "Landlord"
           @property.landlord_id = get_landlord.id
         end
         if get_type == "Tenant"
           @property.tenant_id = get_tenant.id
         end
     
      end 

      if @property.update_attributes(property_params)
        flash[:notice] = 'Property Added / Updated'
        redirect_to action: 'list_property'

        return
      else
        return
        flash[:notice] = 'Error'
      end
    end  

    @property = Property.new 
    @property_id = -1
    
      
  end



  def list_property

    @properties = getproperties

  end


  def view_property

        @property = Property.find params[:id]

  end

   def delete_property

        Property.destroy params[:id]
        
        flash[:notice] = 'Property Deleted!'
        redirect_to action: 'list_property'


  end

  def edit_property
    
    @property = Property.find params[:id]
    @property_id = params[:id]

  end
  
  def payment_dues

    @dues =  Payment.where("landlord_id = ? AND due_date < ? AND STATUS = 'Unpaid'", get_profile.id, Date.today)

  end

  def paid_dues

    @dues =  Payment.where("landlord_id = ? AND STATUS = 'Paid'", get_profile.id)

  end

  def property_payments
  end

  def tenant_payments
  end  

end
