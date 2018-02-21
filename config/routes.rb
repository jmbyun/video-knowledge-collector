Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :knowledge_offers
    resources :videos do
      resources :knowledges
    end
  end
  devise_for :users
end
