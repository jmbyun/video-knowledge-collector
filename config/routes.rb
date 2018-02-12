Rails.application.routes.draw do
  resources :knowledge_offers
  resources :knowledges
  resources :videos
  resources :projects
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
