Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "about_app#index"

  resources :about_app, only: :index
  resources :users, only: [:edit, :update] do
    resources :events, only: [:index, :create, :edit, :update, :destroy] do
      resources :shifts, only: [:index, :create, :edit, :update, :destroy] do
        collection do
          delete :remove_all_shifts
        end
      end
      resources :members, only: [:index, :create, :edit, :update, :destroy] do
        collection do
          post :import
          delete :remove_member_list
        end
      end
      resources :members_schedules do
        collection do
          get :edit_members_schedules
        end
      end
      resources :works, only: [:index, :create, :edit, :update, :destroy]
      resources :works_schedules do
        collection do
          get :edit_works_schedules
        end
      end
    end
  end
end
