Rails.application.routes.draw do
  defaults format: :json do
    resources :scores, only: [:index, :show, :create, :destroy]

    scope '/players/:player' do
      resource :history, only: [:show]
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
