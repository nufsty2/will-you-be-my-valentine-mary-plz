Rails.application.routes.draw do
  root to: "pages#home"
  post '/pages/home', to: "pages#home"
end
