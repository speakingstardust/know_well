Rails.application.routes.draw do
  devise_for :admins
  resources :customers
  resources :jigs
  resources :jig_orders
  resources :jig_order_line_items
  resources :reports
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_scope :user do
    get 'users/index', to: 'users/registrations#index', as: 'user_index'
    get 'users/show/:id', to: 'users/registrations#show', as: 'user_show'
    get 'users/edit/:id', to: 'users/registrations#edit', as: 'user_edit'
    get 'users/new', to: 'users/registrations#new', as: 'new_user'
  end

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
