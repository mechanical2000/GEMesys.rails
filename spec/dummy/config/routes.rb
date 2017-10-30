Rails.application.routes.draw do
  mount Agilibox::Engine => "/agilibox"

  root "sort#sort" # Test sort helper

  get "/dummy" => "dummy#show"
end
