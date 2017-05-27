Rails.application.routes.draw do

 # StaticPage用ルーティング
  get '/dashboard',       to: 'static_pages#dashboard',   as: 'dashboard'
  get '/about',           to: 'static_pages#about',       as: 'about'
  get '/help',            to: 'static_pages#help',        as: 'help'
  get '/convention',      to: 'static_pages#convention',  as: 'convention'

  # User用ルーティング
  resources 'users'

  # TODO: 必要なアクションのみ設定する予定
  # Event用ルーティング
  resources 'events'
  get '/events/:id/edit_port', to: 'events#edit_port', as: 'edit_port_event'

  # EventProgram用ルーテイング
  resources 'event_programs'

  # Ticket用ルーティング
  resources 'tickets'

  # Place用ルーティング
  resources 'places'

  # Sessions用ルーティング
  get     '/login',        to: 'sessions#new'
  post    '/login',        to: 'sessions#create'
  delete  '/logout/:id',   to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
