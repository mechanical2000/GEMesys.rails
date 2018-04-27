Rails.application.routes.draw do
  mount Agilibox::Engine => "/agilibox"

  resources :tests, only: [] do
    collection do
      get :buttons
    end
  end
end
