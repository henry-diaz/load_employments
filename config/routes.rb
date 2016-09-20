Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :api, only: [] do
    collection do
      post 'load_employments'
    end
  end

  root 'home#index'
  get 'employers', to: 'home#employers', constraints: lambda { |req| req.format == :json }
  get 'export', to: 'home#export'
end
