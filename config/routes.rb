Geniedrives::Application.routes.draw do

  get '/parking', to: 'searches#index'

  devise_for :users, :controllers => {:registrations => "registrations"}
  root :to => "pages#index"
  
  namespace :users do
    resources :drives
    get 'dashboard', to: 'dashboards#index'
  end

  get "pages/about"
  get "pages/pricing"
  get "pages/helpcentre"
  get "pages/contactus"
  get "pages/features"
  get "pages/download"
  get "pages/testimonials"

  get "landlords/index"

  resources :landlords
  resources :charges

  #payments
  get "/payment/dues" => "backend#payment_dues"
  get "/payment/paid" => "backend#paid_dues"


  get "/subscription_payment/:id/confirm" => "pages#subscription_payment"
  get "/process/:id/subscription" => "pages#process_subscription"
  get "/process/:id/payment" => "pages#process_payment"

  get "/process/payment" => "pages#process_payment"


  get "/subscribe" => "pages#subscribe"
  get "/renew" => "pages#renew"
  
  get "/backend/:id/checkout" => "backend#checkout"
  get "/backend/redirector" => "backend#redirector"

  get "/landlord/:id/view" => "backend#landlord_view"

  get "/payment/:id/edit" => "backend#payment_edit"
  patch "/payment/:id/edit" => "backend#payment_edit"
  get "/payment/:id/confirm" => "backend#payment_confirm", as: :confirm_payment



  get "/contract/:id/edit" => "backend#contract_edit"
  patch "/contract/:id/edit" => "backend#contract_edit"

  get "/payment/:id/mark_as_paid" => "backend#mark_as_paid"
  get "/contract/:id/view" => "backend#contract_view"
  get "/contract/:id/delete" => "backend#contract_delete"
  get "/contracts/add" => "backend#contracts_add"
  post "/contracts/add" => "backend#contracts_add"

  get "/contracts/list" => "backend#contracts_list"
  get "/contracts/inactive" => "backend#contracts_inactive"


  get "/tenants/list" => "backend#tenant_list"
  get "/tenants/addconnection" => "backend#add_tenant"
  get "/tenants/:id/view" => "backend#tenant_view"

  post "/tenants/addconnection" => "backend#add_tenant"


  get "/connections/:id/delete" => "backend#delete_connection"
  get "/connections/:id/approve" => "backend#approve_connection"
  get "/connections/active" => "backend#active_connections"


  get "/tenant/connection_requests" => "backend#tenant_connection_requests"

  patch "/backend/profile"
  patch "/properties/add" => "backend#add_property"
  post "/properties/add" => "backend#add_property"

  get "/properties/add" => "backend#add_property"
  get "/properties/list" => "backend#list_property"

  get "/properties/:id/view" => "backend#view_property"
  get "/properties/:id/edit" => "backend#edit_property"
  get "/properties/:id/delete" => "backend#delete_property"

  get "/tenant/dashboard" => "backend#tenant_dashboard"
  get "/tenant/profile" => "backend#tenant_profile"
  patch "/tenant/profile" => "backend#tenant_profile"
  get "reports/property_payments" => "backend#property_payments"
  get "reports/tenant_payments" => "backend#tenant_payments"
  

  get "home" => "pages#index"
  get "about" => "pages#about"
  get "pricing" => "pages#pricing"
  get "help-centre" => "pages#helpcentre"
  get "features" => "pages#features"
  get "download" => "pages#download"

  get "contact-us" => "pages#contactus"

  get "backend/" => "backend#dashboard"
  get "backend/index"
  get "backend/dashboard"
  get "backend/profile"
  post "backend/profile"

  get "backend/update_profile"
  get "backend/account_summary"
  

  get "admins/dashboard"
  get "landlords/dashboard"
  get "tenants/dashboard"
  get "redirector/main"

  #handlers
    get "/backend/display_404"



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
