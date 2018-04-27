Rails.application.routes.draw do
  mount Agilibox::Engine => "/agilibox"

  resources :tests, only: [:index] do
    collection do
      get :buttons
      get :filters
    end
  end
end
