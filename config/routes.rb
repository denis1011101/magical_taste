Rails.application.routes.draw do
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

# Defines the root path route ("/")
# root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :mixes, only: [:index, :show] do
        get :availability, on: :collection
        get :selection_of_taste, on: :collection
        get :random_mix, on: :collection
      end
    end
  end
end
