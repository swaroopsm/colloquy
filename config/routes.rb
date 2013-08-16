Colloquy::Application.routes.draw do

  get "attendee/index"

  resources :workshops


  match "attendee/workshops" => "attendee#workshops", :as => "attendee_workshops"

  # boss paths
  resources :boss, :only => [:index]
  resources :attendee, :only => [:index]

  match "boss/pages" => "boss#pages", :as => "boss_pages"
  match "boss/workshops" => 'boss#workshops', :as => 'boss_workshops'
  match "boss/conferences" => "boss#conferences", :as => "boss_conferences"
  match "boss/plenaries" => "boss#plenaries", :as => "boss_plenaries"
  match "boss/attendees" => "boss#attendees", :as => "boss_attendees"
  match "boss/schedule/workshops" => "boss#schedule_workshops", :as => "schedule_workshops"
  match "boss/schedule/plenaries" => "boss#schedule_plenaries", :as => "schedule_plenaries"
  match "boss/schedule/workshop/:workshop_id" => "boss#schedule_workshop", :as => "schedule_workshop"
  match "boss/schedule/plenary/:plenary_id" => "boss#schedule_plenary", :as => "schedule_plenary"
  match "boss/schedules" => "boss#schedules", :as => "boss_schedules"

  match "boss/sendemailtoattendees" => "boss#sendemailtoattendees", :as => "send_email_attendees", :method => :post
  match "boss/emailform" => "boss#emailform", :as => "boss_email_attendees"

  resources :pagecats

  resources :conferences, :only => [:index, :new, :show, :edit, :update, :create, :destroy]

  devise_for :users

  root :to => "home#index"

  resources :conferences, :path => "" , :except => [:index, :new, :show, :edit, :update, :create, :destroy] do
  end

	# Assign & Unassign an abstract
	match 'reviewer/:user_id/abstract/:id/assign' => "submission#assign", :as => "submission_assign", :method => :post
	match 'abstract/:id/unassign' => "submission#unassign", :as => "submission_unassign", :method => :delete

	resources :submissions, :only => [:new, :create], :path => :abstracts do
  	resources :scores
  end


  devise_for :users

    resources :plenaries do
      resources :schedules
    end
    resources :workshops do
      resources :schedules
    end

  resources :conferences, :path => "" do
    resources :plenaries
    resources :workshops
    resources :submissions, :except => [:new, :create], :path => :abstracts
    resources :pages, :path => ""
  end


  resources :submissions, :only => [:new, :create]
  resources :attachments, :only => [:update, :destroy, :edit, :index]

# routes for workshops
  match ':conference_id/workshops/:workshop_id/attend' => 'workshops#attend', :as => 'attend'
  match ':conference_id/workshops/:workshop_id/unattend' => 'workshops#unattend', :as => 'unattend'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
