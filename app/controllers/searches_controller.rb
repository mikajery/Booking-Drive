class SearchesController < ApplicationController
  layout "frontend"
  
  def index
  	
    if !(params[:search].blank?)
      @drives = Drive.near([params[:search]], 50, :order => :distance)
    
    else
    
      @drives = Drive.all
    end
  end
  def query_result
    def show_query
    
########################## Landlord ###############################
  @land_form = true
  @ten_form = true
  if (params[:land_address_1]).blank? && (params[:land_address_2]).blank? && (params[:land_pcode]).blank? && (params[:land_start_date]).blank? && (params[:land_end_date]).blank? && (params[:land_conn_status]).blank? && (params[:land_connection]).blank? && (params[:land_rental_amount]).blank? && (params[:land_paid]).blank? && (params[:land_due]).blank? && (params[:land_name]).blank? && (params[:land_status]).blank? && (params[:land_renewal_date]).blank? && (params[:land_email_address]).blank?
    @land_form = false
  end
  if  (params[:ten_address_1]).blank? && (params[:ten_address_2]).blank? && (params[:ten_pcode]).blank? && (params[:ten_sdate]).blank? && (params[:ten_edate]).blank? && (params[:ten_conn_status]).blank? && (params[:ten_connection]).blank? && (params[:ten_rental_amount]).blank? && (params[:ten_paid]).blank? && (params[:ten_due]).blank? && (params[:ten_name]).blank? && (params[:ten_email_addr]).blank? && (params[:ten_paypal_id]).blank? && (params[:ten_private_amount]).blank? && (params[:ten_private_paid]).blank? && (params[:ten_private_due]).blank?
    @ten_form = false
  end
    
  if params[:land_email_address] != ""
    land_in_user = User.where( email: "#{params[:land_email_address]}").first
      if !(land_in_user).nil?
        @land_user = Landlord.where(user_id: land_in_user.id).first
        #@land_user_attr = Landlord.attribute_names
        if !(@land_user).nil?
          
        ### Finding Property : land_address_1, land_address_2, land_pcode ##
          if !(params[:land_address_1].blank?)
            if !(params[:land_address_2].blank?)
              if !(params[:land_pcode].blank?)
                @properties_result= Property.where(landlord_id: @land_user.id, address_line_1: params[:land_address_1], address_line_2: params[:land_address_2], post_code: params[:land_pcode])
        
              else
                @properties_result= Property.where(landlord_id: @land_user.id, address_line_1: params[:land_address_1], address_line_2: params[:land_address_2])
        
              end
            else
              if !(params[:land_pcode].blank?)
                @properties_result= Property.where(landlord_id: @land_user.id, address_line_1: params[:land_address_1], post_code: params[:land_pcode])
        
              else
                @properties_result= Property.where(landlord_id: @land_user.id, address_line_1: params[:land_address_1])
        
              end
            end
          else
            if !(params[:land_address_2].blank?)
              if !(params[:land_pcode].blank?)
                @properties_result= Property.where(landlord_id: @land_user.id, address_line_2: params[:land_address_2], post_code: params[:land_pcode])
        
              else
                @properties_result= Property.where(landlord_id: @land_user.id, address_line_2: params[:land_address_2])
        
              end
            else
              if !(params[:land_pcode].blank?)
                @properties_result= Property.where(landlord_id: @land_user.id, post_code: params[:land_pcode])
        
              else
                @properties_result= Property.where(landlord_id: @land_user.id)
        
              end
            end
          end
        ### Finding Property End ###

        ### Finding Contracts : land_start_date, land_end_date##
          if !(params[:land_start_date].blank?)
            if !(params[:land_end_date].blank?)
              @contracts= Contract.where("landlord_id = ? AND start_date >= ? AND end_date<= ?", @land_user.id, convert_strptime(params[:land_start_date]), convert_strptime(params[:land_end_date]))
              
            else
              @contracts= Contract.where("landlord_id = ? AND start_date >= ?", @land_user.id, convert_strptime(params[:land_start_date]))
              
            end
          else
            if !(params[:land_end_date].blank?)
              @contracts= Contract.where("landlord_id = ? AND end_date<= ?", @land_user.id, convert_strptime(params[:land_end_date]))
            else
              @contracts = Contract.where(landlord_id: @land_user.id)
            end
          end
        ### Finding Contracts End ###

        ### Finding Connections : land_approved, land_pending, land_connection ##
          if params[:land_conn_status] == "Approved"
            conn_items = Connection.count(conditions: {landlord_email: land_in_user.email, approved: "1"}).to_s
            if !(params[:land_connection]).blank? && conn_items.to_s == "#{params[:land_connection]}"
              @connections = Connection.where(landlord_email: land_in_user.email, approved: "1")  
            elsif (params[:land_connection]).blank?
              @connections = Connection.where(landlord_email: land_in_user.email, approved: "1")
            end
          elsif params[:land_conn_status] == "Pending"
            conn_items = Connection.count(conditions: {landlord_email: land_in_user.email, approved: "0"})
            if !(params[:land_connection]).blank? && conn_items.to_s == "#{params[:land_connection]}"
              @connections = Connection.where(landlord_email: land_in_user.email, approved: "0")  
            elsif (params[:land_connection]).blank?
              @connections = Connection.where(landlord_email: land_in_user.email, approved: "0")
            end
          else
            conn_items = Connection.where(landlord_email: land_in_user.email).count
            if !(params[:land_connection]).blank? 
              @connections = Connection.where(landlord_email: land_in_user.email) 
            elsif (params[:land_connection]).blank?
              @connections = Connection.where(landlord_email: land_in_user.email)
            end
          end
              
        ### Finding Connections End ###

        ### Finding Shared Payments : land_rental_amount, land_paid, land_due ##
          if (params[:land_rental_amount]).blank?
            
            if (params[:land_paid]).blank?
              if(params[:land_due]).blank?
                @payments = Payment.where(landlord_id: @land_user.id) 
              else
                @payments = Payment.where(landlord_id: @land_user.id, due_date: params[:land_due])
              end
            else
              if(params[:land_due]).blank?
                @payments = Payment.where(landlord_id: @land_user.id, date_paid: params[:land_paid])        
              else
                @payments = Payment.where(landlord_id: @land_user.id, date_paid: params[:land_paid], due_date: params[:land_due])       
              end
            end
          else
            if (params[:land_paid]).blank?
              if(params[:land_due]).blank?
        
                @payments = Payment.where(landlord_id: @land_user.id, amount: params[:land_rental_amount])    
              else
                @payments = Payment.where(landlord_id: @land_user.id, amount: params[:land_rental_amount], due_date: params[:land_due])
              end
            else
              if(params[:land_due]).blank?
                @payments = Payment.where(landlord_id: @land_user.id, amount: params[:land_rental_amount], date_paid: params[:land_paid])       
              else
                @payments = Payment.where(landlord_id: @@land_user.id, amount: params[:land_rental_amount], date_paid: params[:land_paid], due_date: params[:land_due])       
              end
            end
          end
        ### Finding Shared Payments End ###

        ### Finding Profile : land_name, land_status, land_renewal_date, land_email_address ##
          #landName = "first_name: \'#{params[:land_name]}\'" if !(params[:land_name]).blank? 
          query_str = "user_id = \'#{land_in_user.id}\' "+"#{query_exp(params[:land_name], "first_name")}"+"#{query_exp(params[:land_status], "subscription_type")}"+"#{query_exp(params[:land_renewal_date], "updated_at")}"

            @profiles = Landlord.where(query_str)
          
          
        ### Finding Profile End ###
      end
    end
  else ### --------------------------- Else --------------
    ### Finding Property : land_address_1, land_address_2, land_pcode ##
      if !(params[:land_address_1].blank?)
        if !(params[:land_address_2].blank?)
          if !(params[:land_pcode].blank?)
            @properties_result= Property.where(address_line_1: params[:land_address_1], address_line_2: params[:land_address_2], post_code: params[:land_pcode])
    
          else
            @properties_result= Property.where(address_line_1: params[:land_address_1], address_line_2: params[:land_address_2])
    
          end
        else
          if !(params[:land_pcode].blank?)
            @properties_result= Property.where(address_line_1: params[:land_address_1], post_code: params[:land_pcode])
    
          else
            @properties_result= Property.where(address_line_1: params[:land_address_1])
    
          end
        end
      else
        if !(params[:land_address_2].blank?)
          if !(params[:land_pcode].blank?)
            @properties_result= Property.where(address_line_2: params[:land_address_2], post_code: params[:land_pcode])
    
          else
            @properties_result= Property.where(address_line_2: params[:land_address_2])
    
          end
        else
          if !(params[:land_pcode].blank?)
            @properties_result= Property.where(post_code: params[:land_pcode])
    
          else
            @properties_result= Property.all
    
          end
        end
      end
    ### Finding Property End ###

    ### Finding Contracts : land_start_date, land_end_date##
      if !(params[:land_start_date].blank?)
        if !(params[:land_end_date].blank?)
          @contracts= Contract.where("start_date >= ? AND end_date<= ?", convert_strptime(params[:land_start_date]), convert_strptime(params[:land_end_date]))
          
        else
          @contracts= Contract.where("start_date >= ?", convert_strptime(params[:land_start_date]))
          
        end
      else
        if !(params[:land_end_date].blank?)
          @contracts= Contract.where("end_date<= ?", convert_strptime(params[:land_end_date]))
        else
          @contracts = Contract.all
        end
      end
    ### Finding Contracts End ###

    ### Finding Connections : land_approved, land_pending, land_connection ##
      @land_conn_status = params[:land_conn_status]
      @land_conn_count = params[:land_connection]
      
          
    ### Finding Connections End ###

    ### Finding Shared Payments : land_rental_amount, land_paid, land_due ##
      if (params[:land_rental_amount]).blank?
        
        if (params[:land_paid]).blank?
          if(params[:land_due]).blank?
            @payments = Payment.all
          else
            @payments = Payment.where(due_date: params[:land_due])
          end
        else
          if(params[:land_due]).blank?
            @payments = Payment.where(date_paid: params[:land_paid])        
          else
            @payments = Payment.where(date_paid: params[:land_paid], due_date: params[:land_due])       
          end
        end
      else
        if (params[:land_paid]).blank?
          if(params[:land_due]).blank?
    
            @payments = Payment.where(amount: params[:land_rental_amount])    
          else
            @payments = Payment.where(amount: params[:land_rental_amount], due_date: params[:land_due])
          end
        else
          if(params[:land_due]).blank?
            @payments = Payment.where(amount: params[:land_rental_amount], date_paid: params[:land_paid])       
          else
            @payments = Payment.where(amount: params[:land_rental_amount], date_paid: params[:land_paid], due_date: params[:land_due])        
          end
        end
      end
    ### Finding Shared Payments End ###

    ### Finding Profile : land_name, land_status, land_renewal_date, land_email_address ##
      #landName = "first_name: \'#{params[:land_name]}\'" if !(params[:land_name]).blank? 
      if !(params[:land_name]).blank?
        query_str = "first_name = \'#{params[:land_name]}\'"+"#{query_exp(params[:land_status], "subscription_type")}"+"#{query_exp(params[:land_renewal_date], "updated_at")}"
      elsif !(params[:land_status]).blank?
        query_str = "subscription_type = \'#{params[:land_status]}\'"+"#{query_exp(params[:land_name], "first_name")}"+"#{query_exp(params[:land_renewal_date], "updated_at")}"
      elsif !(params[:land_renewal_date]).blank?
        query_str = "updated_at = \'#{params[:land_renewal_date]}\'" + "#{query_exp(params[:land_name], "first_name")}"+"#{query_exp(params[:land_status], "subscription_type")}"
      else
        query_str = "#{query_exp(params[:land_name], "first_name")}"+"#{query_exp(params[:land_status], "subscription_type")}"+"#{query_exp(params[:land_renewal_date], "updated_at")}"
      end
        
      
      @profiles = Landlord.where(query_str)
      
    ### Finding Profile End ###
  end

########################## Tenant ###############################
  if !(params[:ten_email_addr]).blank?
    ten_in_user = User.where( email: "#{params[:ten_email_addr]}").first
    @ten_user = Tenant.where(user_id: ten_in_user.id).first
    ### Finding Property : ten_address_1, ten_address_2, ten_pcode ##
      query_str = "tenant_id = \'#{@ten_user.id}\'"+"#{query_exp(params[:ten_address_1], "address_line_1")}"+"#{query_exp(params[:ten_address_2], "address_line_2")}"+"#{query_exp(params[:ten_pcode], "post_code")}"
      @ten_propertise = Property.where(query_str)
    ### Finding Property End ###

    ### Finding Contracts : ten_sdate, ten_edate##
      query_str = "tenant_id = \'#{@ten_user.id}\'"+"#{query_date(params[:ten_sdate], "start_date", "Start")}"+"#{query_date(params[:ten_edate], 'end_date', 'End')}"
      @ten_contracts = Contract.where(query_str)
    ### Finding Contracts End ###

    ### Finding Connections : ten_approved, ten_pending, ten_connection ##
      query_str = "tenant_id = \'#{@ten_user.id}\'"+"#{query_exp(params[:ten_conn_status], 'approved')}"
      
      unless (params[:ten_connection]).blank?
        ten_conn = Connection.where(query_str).count.to_s
        if ten_conn >= params[:ten_connection]
          @ten_connections = Connection.where(query_str)
        end
      else
        @ten_connections = Connection.where(query_str)
      end
    ### Finding Connections End ###

    ### Finding Shared Payments : ten_rental_amount, ten_paid, ten_due ##
      query_str = "tenant_id = \'#{@ten_user.id}\'"+"#{query_exp(params[:ten_rental_amount], 'amount')}"+"#{query_date(params[:ten_paid], 'date_paid', 'Equal')}"+"#{query_date(params[:ten_due], 'due_date', 'Equal')}"
      @ten_payments = Payment.where(query_str)
    ### Finding Shared Payments End ###

    ### Finding Private Payments : ten_private_amount, ten_private_paid, ten_private_due ##
      query_str = "tenant_id = \'#{@ten_user.id}\'"+"#{query_exp(params[:ten_private_amount], 'amount')}"+"#{query_date(params[:ten_private_paid], 'paid_date', 'Equal')}"+"#{query_date(params[:ten_private_due], 'created_date', 'Equal')}"
      @ten_private_payments = OffPayment.where(query_str)
    ### Finding Private Payments End ###

    ### Finding Profile : ten_name, ten_email_addr, ten_paypal_id ##
      query_str = "user_id = \'#{ten_in_user.id}\' "+"#{query_exp(params[:ten_name], "first_name")}"
      @ten_profiles = Tenant.where(query_str)
    ### Finding Profile End ###
  else
    ### Finding Property : ten_address_1, ten_address_2, ten_pcode ##
      if !(params[:ten_address_1]).blank?
        query_str = "address_line_1 = \'#{params[:ten_address_1]}\'"+"#{query_exp(params[:ten_address_2], "address_line_2")}"+"#{query_exp(params[:ten_pcode], "post_code")}"
      elsif !(params[:ten_address_2]).blank?
        query_str = "address_line_2 = \'#{params[:ten_address_2]}\'"+"#{query_exp(params[:ten_address_1], "address_line_1")}"+"#{query_exp(params[:ten_pcode], "post_code")}"
      elsif !(params[:ten_pcode]).blank?
        query_str = "post_code = \'#{params[:ten_pcode]}\'"+"#{query_exp(params[:ten_address_1], "address_line_1")}"+"#{query_exp(params[:ten_address_2], "address_line_2")}"
      else
        query_str = "#{query_exp(params[:ten_address_1], "address_line_1")}"+"#{query_exp(params[:ten_address_2], "address_line_2")}"+"#{query_exp(params[:ten_pcode], "post_code")}"
      end
      @ten_propertise = Property.where(query_str)
    ### Finding Property End ###

    ### Finding Contracts : ten_sdate, ten_edate##
      if !(params[:ten_sdate]).blank?
        query_str = "start_date = \'#{params[:ten_sdate]}\'"+"#{query_date(params[:ten_edate], 'end_date', 'End')}"
      elsif !(params[:ten_edate]).blank?
        query_str = "end_date = \'#{params[:ten_edate]}\'"+"#{query_date(params[:ten_sdate], "start_date", "Start")}"       
      else
        query_str = "#{query_date(params[:ten_sdate], "start_date", "Start")}"+"#{query_date(params[:ten_edate], 'end_date', 'End')}"
      end
        
      @ten_contracts = Contract.where(query_str)
    ### Finding Contracts End ###

    ### Finding Connections : ten_approved, ten_pending, ten_connection ##
      @ten_conn_status = params[:ten_conn_status]
      @ten_conn_count = params[:ten_connection]
      
    ### Finding Connections End ###

    ### Finding Shared Payments : ten_rental_amount, ten_paid, ten_due ##
      if !(params[:ten_rental_amount]).blank?
        query_str = "amount = \'#{params[:ten_rental_amount]}\'"+"#{query_date(params[:ten_paid], 'date_paid', 'Equal')}"+"#{query_date(params[:ten_due], 'due_date', 'Equal')}"
      elsif !(params[:ten_paid]).blank?
        query_str = "date_paid = \'#{params[:ten_paid]}\'"+"#{query_exp(params[:ten_rental_amount], 'amount')}"+"#{query_date(params[:ten_due], 'due_date', 'Equal')}"
      elsif !(params[:ten_due]).blank?
        query_str = "due_date = \'#{params[:ten_due]}\'"+"#{query_exp(params[:ten_rental_amount], 'amount')}"+"#{query_date(params[:ten_paid], 'date_paid', 'Equal')}"
      else
        query_str = "#{query_exp(params[:ten_rental_amount], 'amount')}"+"#{query_date(params[:ten_paid], 'date_paid', 'Equal')}"+"#{query_date(params[:ten_due], 'due_date', 'Equal')}"
      end
      @ten_payments = Payment.where(query_str)
    ### Finding Shared Payments End ###

    ### Finding Private Payments : ten_private_amount, ten_private_paid, ten_private_due ##
      if !(params[:ten_private_amount]).blank?
        query_str = "amount = \'#{params[:ten_private_amount]}\'"+"#{query_date(params[:ten_private_paid], 'paid_date', 'Equal')}"+"#{query_date(params[:ten_private_due], 'created_date', 'Equal')}"
      elsif !(params[:ten_private_paid]).blank?
        query_str = "paid_date = \'#{params[:ten_private_paid]}\'"+"#{query_exp(params[:ten_private_amount], 'amount')}"+"#{query_date(params[:ten_private_due], 'created_date', 'Equal')}"
      elsif !(params[:ten_private_due]).blank?
        query_str = "created_date = \'#{params[:ten_private_due]}\'"+"#{query_exp(params[:ten_private_amount], 'amount')}"+"#{query_date(params[:ten_private_paid], 'paid_date', 'Equal')}"
        else
          query_str = "#{query_exp(params[:ten_private_amount], 'amount')}"+"#{query_date(params[:ten_private_paid], 'paid_date', 'Equal')}"+"#{query_date(params[:ten_private_due], 'created_date', 'Equal')}"
      end
      @ten_private_payments = OffPayment.where(query_str)
    ### Finding Private Payments End ###

    ### Finding Profile : ten_name, ten_email_addr, ten_paypal_id ##
      if !(params[:ten_name]).blank?
        query_str = "first_name = \'#{params[:ten_name]}\'"
      else
        query_str = "#{query_exp(params[:ten_name], "first_name")}"
      end
      @ten_profiles = Tenant.where(query_str)
    ### Finding Profile End ###

  end
  respond_to do |format|
     format.js { render 'show_query.js.erb' }
     
  end 
  end
end
