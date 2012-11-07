OzjapaneseComAu::Application.routes.draw do
  
  resources :ozmains, :only => ["index"] do
    collection do
      get :about
      post :uzatt
      post :recent_top_feed
      post :recent_comment_feed
    end
  end
  
  resources :sessions, :only => [] do
    collection do
      post :signin
    end
  end
  
  devise_for :flyers, :controllers => { :omniauth_callbacks => "flyers/omniauth_callbacks" }
  #devise_scope :flyers do
  #  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  #  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_flyer_session
  #end
  
  resources :ozs, :only => ['index'] do
    collection do
      get :older
      get :newer
      get :write
      get :cancel
      post :viewed
      get :link_view
      post :carousel_viewed
      get :feed_view
      post :select_heading
      post :upload_image
    end
  end
  
  
  resources :terms, :only => ["index","create"]
  resources :images, :only => ["create"]
  resources :oz_employments, :only => ["create"]
  resources :oz_employers, :only => ["create"]
  resources :oz_sell_goods, :only => ["create"]
  resources :oz_buy_goods, :only => ["create"]
  resources :oz_estate_share_rents, :only => ["create"]
  resources :oz_info_events, :only => ["create"]
  resources :oz_people_pros, :only => ["create"]
  resources :oz_info_living_smarts, :only => ["create"]
  resources :oz_info_living_qnas, :only => ["create"]
  
  resources :contacts, :only => ["index","new","create"]
  resources :comments, :only => ['index'] do
  collection do
      post :post_comment
      post :view_all
    end
  end
  
  match 'counters/batch', :via => :get

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'ozmains#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
