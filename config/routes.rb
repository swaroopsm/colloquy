Colloquy::Application.routes.draw do

  devise_for :users, :skip => [:registrations]
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users' => 'devise/registrations#update', :as => 'user_registration'
    end

	# Participate path
	match "participate" => "home#participate", :as => "participate"
	match "signup" => "users#participate", :as => "participate", :method => :post

  # boss paths
  resources :boss, :only => [:index]
  match "boss/pages" => "boss#pages", :as => "boss_pages"
  match "boss/workshops" => 'boss#workshops', :as => 'boss_workshops'
  match "boss/conferences" => "boss#conferences", :as => "boss_conferences"
  match "boss/plenaries" => "boss#plenaries", :as => "boss_plenaries"
  match "boss/attendees" => "boss#attendees", :as => "boss_attendees"
  match "boss/attendee/new" => "boss#new_attendee", :as => "boss_new_attendee"
  match "boss/attendee/create" => "boss#create_attendee", :as => "boss_create_attendee", :method => :post
  match "boss/attendees/:user_id" => "boss#attendees_show", :as => "boss_attendees_show"
  match "boss/attendees/:user_id/workshops/:workshop_id/unattend" => "workshops#unattend", :as => "boss_attendees_workshops_unattend"
  match "boss/submissions" => "boss#submissions", :as => "boss_submissions"
  match "boss/sessions" => "boss#sessions_submissions", :as => "sessions_submissions"
  match "boss/sessions/list" => "boss#sessions_list", :as => "boss_sessions_list"
	match "boss/sessions/:submission_id/new" => "allotments#new", :as => "new_sessions_allotment"  
	match "boss/sessions/:submission_id" => "allotments#create", :as => "sessions_allotment", :method => :post  
	match "boss/sessions/:period_id/submissions" => "periods#submissions", :as => "period_submissions"  
	match "boss/allotments/:allotment_id/edit" => "allotments#edit", :as => "edit_sessions_allotment" 
	match "boss/allotment/:allotment_id" => "allotments#update", :as => "allotment", :method => :put 
	match "boss/allotments/:allotment_id" => "allotments#destroy", :as => "destroy_sessions_allotment", :method => :delete  
	match "boss/allotments/:allotment_id/arrange/:order_position" => "allotments#arrange", :as => "arrange_allotment", :method => :post  
	match "boss/allotments" => "boss#allotments", :as => "allotments"
  match "boss/schedule/submissions" => "boss#schedule_submissions", :as => "schedule_workshops"
  match "boss/schedule/workshops" => "boss#schedule_workshops", :as => "schedule_workshops"
  match "boss/schedule/plenaries" => "boss#schedule_plenaries", :as => "schedule_plenaries"
  match "boss/schedule/sessions" => "boss#schedule_periods", :as => "schedule_sessions"
  match "boss/schedule/workshop/:workshop_id" => "boss#schedule_workshop", :as => "schedule_workshop"
  match "boss/schedule/plenary/:plenary_id" => "boss#schedule_plenary", :as => "schedule_plenary"
  match "boss/schedule/session/:period_id" => "boss#schedule_period", :as => "schedule_session"
  match "boss/schedule/:id/edit" => "schedules#edit", :as => "edit_schedule"
  match "boss/schedule/:id" => "schedules#update", :as => "update_schedule", :method => :put
  match "boss/schedule/:id/destroy" => "schedules#destroy", :as => "destroy_schedule", :method => :delete
  match "boss/schedules" => "boss#schedules", :as => "boss_schedules"
  match "boss/sendemailtoattendees" => "boss#sendemailtoattendees", :as => "send_email_attendees", :method => :post
  match "boss/emailform" => "boss#emailform", :as => "boss_email_attendees"

  # Attendee Paths
  resources :attendee, :only => [:index]
  match "attendee/workshops" => "attendee#workshops", :as => "attendee_workshops"

  resources :pagecats



  root :to => "home#index"

	# Assign & Unassign an abstract
	match 'reviewer/:user_id/abstract/:id/assign' => "submission#assign", :as => "submission_assign", :method => :post
	match 'abstract/:id/unassign' => "submission#unassign", :as => "submission_unassign", :method => :delete

	resources :submissions, :only => [:new, :create], :path => :abstracts do
  	resources :scores
  end

  resources :plenaries do
    resources :schedules
  end

  resources :workshops do
    resources :schedules
  end

  resources :periods, :path => :sessions do
    resources :schedules
  end

  # resources :submissions, :only => [:new, :create]
  resources :attachments, :only => [:update, :destroy, :edit, :index]

# routes for workshops
  match ':conference_id/workshops/:workshop_id/attend' => 'workshops#attend', :as => 'attend'
  match ':conference_id/workshops/:workshop_id/unattend' => 'workshops#unattend', :as => 'unattend'

  match ':conference_id/talks/' => 'submissions#talks', :as => 'conference_talks'
  match ':conference_id/posters/' => 'submissions#posters', :as => 'conference_posters'
  match ':conference_id/real-schedule/' => 'home#schedule', :as => 'conference_schedule'

  resources :conferences, :only=> [:edit, :destroy, :update]

  resources :conferences, :except=> [:edit, :destroy, :update], :path => "" do
  	resources :boards do
  		resources :ideas
		end
		resources :periods, :path => :sessions
    resources :plenaries
    resources :workshops
    resources :submissions, :except => [:new, :create], :path => :abstracts
    resources :topics
    resources :pages, :path => ""
  end

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
