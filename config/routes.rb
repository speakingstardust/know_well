Rails.application.routes.draw do
  resources :jig_work_orders do
    put :receive
    put :complete
    put :verify_completed
    put :ship
    get 'signature', to: 'jig_work_orders#new_signature', as: 'signature'
  end
  devise_for :admins
  resources :signatures, only: [:new, :destroy, :create]
  resources :customers
  resources :jigs
  resources :jig_orders
  resources :jig_order_line_items
  resources :reports
  devise_for :users
  scope "/admin" do 
    resources :users
  end
  get 'jig_work_orders/packing_slip/:id', to: 'jig_work_orders#packing_slip', as: 'packing_slip'
  get 'work_orders_management' => "pages#work_orders", as: 'work_orders_management'
  get 'jig_work_orders/print/:id', to: 'jig_work_orders#print', as: 'print_jig_work_order'
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
