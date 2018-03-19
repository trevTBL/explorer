Explorer::Engine.routes.draw do

  root to: 'listings#index'
  resources :events, path: :e
  resources :venues, path: :v
  resources :listings, path: :l
  resources :organizers, path: :o
  resources :memberships
  resources :users
  resources :categories
  
  
  match 'day' => 'events#day', :via => 'get'
  match 'week' => 'events#week', :via => 'get'
  match 'month' => 'events#month', :via => 'get'
  match 'new' => 'events#new', :via => 'get'
  match 'now' => 'events#now', :via => 'get'
  match 'gates' => 'events#gatekeeper', :via => 'get'
  match 'my-events' => 'events#my_events', :via => 'get'
  match 'my-tickets' => 'events#my_tickets', :via => 'get'
  match 'grid' => 'pages#grid', :via => 'get'
  match 'load-more' => 'pages#more', :via => 'get'
  match 'browse' => 'pages#browse', :via => 'get'
  match '/find-events' => 'pages#find', :via => 'get'
  match '/coming-soon' => 'pages#soon', :via => 'get'
  match 'confirm' => 'pages#confirm', :via => 'get'

  mount Ckeditor::Engine => '/ckeditor'

end
