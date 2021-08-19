Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  # match 'payment', to: 'payment#post', via: [:post]

  resources :payment, :cancel, :inquiry
end
