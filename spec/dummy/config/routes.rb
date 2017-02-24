Rails.application.routes.draw do
  mount Agilibox::Engine => "/agilibox"

  root "sort#sort" # Test sort helper
end
