Rails.application.routes.draw do
  resources :documents
    resources :procedure_types
    resources :list_categories, except: [:show]
    resources :reports, except: [:new,:index]
    get 'reports/new/:procedure_id' => 'reports#new'
    resources :announcements
    resources :verified_lists
    root 'static_pages#home'

    resources :verification_lists

    # resources :people
    # devise_for :users, :controllers => {:registrations => 'registrations'}
    # devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
    devise_for :users

    get '/logout' => 'static_pages#logout'

    get '/procedures/begin' => 'procedures#begin'
    post '/procedures/new' => 'procedures#new'
    get '/procedures/assign' => 'procedures#assign'
    post 'procedures/pick_verif_list' => 'verified_lists_controller#create'
    post '/procedures/:id/update' => 'procedures#update'
    post '/procedures/:id/send' => 'procedures#send_to_chief'
    post '/procedures/:id/finish' => 'procedures#finish'
    resources :procedures, except: [:update, :new]

    resources :users
    resources :companies
    resources :projects
    resources :roles

  get '/legal_agents/new/:company_id' => 'legal_agents#new2'
  resources :legal_agents ,except: [:update]
    post '/legal_agents/:id/update' => 'legal_agents#update'

    resources :employees
    post '/employees/:id/update' => 'employees#update'
    get '/employees/:id/update' => 'employees#edit'

    get '/orders/subregion_options' => 'static_pages#subregion_options'

    get '/users/annul/:id' => 'users#annul'
    get '/users/activate/:id' => 'users#activate'

    # get 'error' => 'static_pages#error'
    post '/createuser' => 'users#create'
    get '/verify/:id' => 'verified_lists#verify'

    get '/employeeAnnouncements' => 'announcements#employeeAnnouncements'
    get '/:dummy' => 'static_pages#error'
    get '/fonts/:dummy' => 'static_pages#error'
    get '/assets/underscore-min.map' => 'static_pages#error'

  # root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "roo

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
