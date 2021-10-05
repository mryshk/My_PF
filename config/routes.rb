Rails.application.routes.draw do
  devise_for :creaters
  devise_for :listeners
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
