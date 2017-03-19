Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :status
  resource :async_status
  resource :update_status
  resource :searching_user_not_use_index, controller: :searching_user_not_use_index
  resource :searching_user_use_index, controller: :searching_user_use_index
end
