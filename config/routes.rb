Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "projects#index"
  resources :projects do
    resources :knowledge_offers
    post 'knowledge_offers/:id/approve(.:format)', to: 'knowledge_offers#approve'
    post 'knowledge_offers/:id/disapprove(.:format)', to: 'knowledge_offers#disapprove'
    resources :videos do
      resources :knowledges
    end
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
end
