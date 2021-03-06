Rails.application.routes.draw do
  mount Agilibox::Engine => "/agilibox"

  resources :tests, only: [:index] do
    collection do
      get :buttons
      get :cards
      get :dummy_models
      get :filters
      get :search
      get :checkboxes_dropdown
      match :modals, via: [:get, :post]
    end
  end
end
