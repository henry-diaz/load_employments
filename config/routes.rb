Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :api, only: [] do
    collection do
      post 'load_employments'
    end
  end
end
