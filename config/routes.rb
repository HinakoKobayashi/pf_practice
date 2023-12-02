Rails.application.routes.draw do

  # ユーザー用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  get '/search' => 'searches#search'
  get '/tag/search' => 'searches#tag_search'

  resources :posts, except: [:new] 

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :edit, :show, :update]
    resources :tags, only: [:index, :edit, :create, :update, :destroy]
    
  end
  
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: [:index, :edit, :show, :update] do
      collection do
        get :check
        patch :cancellation
      end
    end
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
