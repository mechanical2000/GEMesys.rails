Rails.application.routes.draw do
  mount Agilibox::Engine => "/agilibox"

  get "/dummy" => "dummy#show"
end
