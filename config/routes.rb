Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'

    get '/jaunumi/:id', to: "posts#show", :as => 'jaunums'
    get '/jaunumi', to: "posts#index", :as => 'jaunumi'

    get '/lapa/:id', to: "pages#show", :as => 'lapa'
    get '/galerijas/:id', to: "albums#show", :as => 'galerija'
    get '/galerijas', to: "albums#index", :as => 'galerijas'

    get ':page_id', :as => :page, 
                    :via => :get, 
                    :controller => :pages, 
                    :action => :show

    resources :pages, only: [:show, :index] do
      member do
        get :show
      end  
    end  

    resources :contact_forms, only: [:create] 

    root :to => 'pages#show', :id => Page.where(:visible =>  true).order("position asc").first.slug if (ActiveRecord::Base.connection.table_exists? 'pages' and Page.count > 0)
    
    get '*path' => redirect('/')
end
