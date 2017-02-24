Agilibox::Engine.routes.draw do
  namespace :small_data do
    resources :filters, only: [:create]
  end
end
