MyCUplanner::Application.routes.draw do
  resources :events

  # courses routes
  # resources :courses
  # get "courses/new"
  
  # In our application Products is a RESTful resource so the two new actions won’t be accessible 
  # without making a change to our routes file. As we’re adding methods that will work on a 
  # collection of products we’ll use the :collection option to add our two new actions.

  # The :collection option takes a hash of values. Each key is the name of an action and each value 
  # is the method that that action should use. As mentioned earlier we’re using POST 
  # for the select_multiple action, even though ideally we should use GET.
  # resources :courses, :collection => { :select_multiple => :post, :update_multiple => :put }

  resources :courses do
    collection do
      post 'select_multiple'
      put 'update_multiple'
      post 'delete_multiple'
    end
  end

  # static pages routes
  root :to => 'users#home'
  match '/about',   to: 'dynamic_pages#about',   via: 'get'
  match '/contact', to: 'dynamic_pages#contact', via: 'get'


  # users routes
  resources :users
  get "users/new"
  match '/signup',  to: 'users#new', via: 'get'
  match '/home', to: 'users#home', via: 'get'

  # sign in / sign out routes
  resources :sessions, only: [:new, :create, :destroy]
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'


  resource :calendar, :only => [:show]
  #match '/calendar', to 'calendar#show', via: 'get'
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