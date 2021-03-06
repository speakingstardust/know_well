Rails.application.routes.draw do
  resources :jig_work_orders do
    put :receive
    put :complete
    put :verify_completed
    put :ship
    put :archive
    get 'signature', to: 'jig_work_orders#new_signature', as: 'signature'
  end
  devise_for :admins
  resources :signatures, only: [:new, :destroy, :create]
  resources :projects do
    resources :tasks do
      get "delete"
      put :complete
      put :uncomplete
      put :up
      put :down
      put :top
      put :bottom
    end
    resources :progress_notes do
      get "delete"
    end
    resources :comments do 
      get "delete"
    end
  end
  resources :meico_products do 
    resources :documents
  end
  resources :document_mail_logs
  resources :scope_of_works
  resources :customers do
    resources :contacts
  end
  resources :jigs
  resources :jig_orders
  resources :jig_order_line_items
  resources :expense_reports
  get "create_summary_report", to: 'expense_reports#create_summary_report', as: 'create_expense_summary_report'
  get "summary_report", to: "expense_reports#summary_report", as: 'expense_summary_report'
  resources :reports
  put 'products/all', to: 'products#update_all_counts', as: 'update_all_counts'
  get 'safety_data_sheets', to: 'safety_data_sheets#index', as: 'safety_data_sheets'
  resources :products do
    resources :safety_data_sheets
  end
  resources :product_reports
  resources :orders
  resources :manufacturers
  resources :vendors
  devise_for :users
  scope "/admin" do 
    resources :users
  end
  get :master_gantt, to: 'projects#master_gantt', as: 'master_gantt'
  get 'product_count', to: 'products#count', as: 'product_count'
  get 'inventory_home', to: 'pages#inventory_home', as: 'inventory_home'
  get 'jig_work_orders/packing_slip/:id', to: 'jig_work_orders#packing_slip', as: 'packing_slip'
  get 'work_orders_management' => "pages#work_orders", as: 'work_orders_management'
  get 'jig_work_orders/print/:id', to: 'jig_work_orders#print', as: 'print_jig_work_order'
  get 'product_reports/print/:id', to: 'product_reports#print', as: 'print_product_report'
  post 'work_orders_management' => "pages#new_work_order"
  get 'jig_reporting' => "pages#jig_reporting"
  get '/reports/print/:id', to: 'reports#print', as: 'print_report'
  post 'jig_summary_report' => "jig_orders#index", defaults: { format: 'pdf' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

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
